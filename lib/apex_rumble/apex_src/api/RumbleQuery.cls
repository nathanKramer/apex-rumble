/**
 * RumbleQuery.cls
 * Description: Dynamic SOQL builder
 * @author: Nathan
 * @date: 05 May 2017 (Friday)
 */
public with sharing class RumbleQuery { // First cut uses strings only
	public class IncompleteQueryException extends Exception {}
	public class PoorlyFormedArgumentException extends Exception {}

	public enum Direction { ASCENDING, DESCENDING }
	public class OrderClause {
		private String field;
		private Direction sortDirection;

		public OrderClause(String fieldName, String dir) {
			this.field = fieldName;
			if (dir == 'ASCENDING' || dir == 'ASC') {
				this.sortDirection = Direction.ASCENDING;
			} else if (dir == 'DESCENDING' || dir == 'DESC') {
				this.sortDirection = Direction.DESCENDING;
			} else {
				throw new PoorlyFormedArgumentException(dir + ' is not a valid sorting direction');
			}
		}

		public override String toString() {
			return field + ' ' + sortDirection.name();
		}
	}

	private String what;
	private List<String> filters;
	private String rowLimit;
	private List<RumbleQuery> subQueries;
	private List<OrderClause> orderClauses;

	public RumbleQuery() {
		this.filters = new List<String>();
		this.subQueries = new List<RumbleQuery>();
		this.orderClauses = new List<OrderClause>();
	}

	public RumbleQuery find(String objectApiName) {
		//this.what = Schema.getGlobalDescribe().get(objectApiName);
		this.what = objectApiName;
		return this;
	}

	public RumbleQuery find(RumbleModel example) {
		this.what = example.getSObjectType().getDescribe().getName();
		return this;
	}

	public RumbleQuery filterBy(List<String> filters) {
		this.filters.addAll(filters);
		return this;
	}

	public RumbleQuery filterBy(String filter) {
		return this.filterBy(new List<String> { filter });
	}

	public RumbleQuery filterBy(RumbleModel example) {
		return this.filterBy(example.getSObject());
	}

	public RumbleQuery filterBy(SObject example) {
		if (this.what == null) {
			this.what = example.getSObjectType().getDescribe().getName();
		}
		return this.filterBy(example.getPopulatedFieldsAsMap());
	}

	public RumbleQuery filterBy(Map<String, Object> filterMap) {
		List<String> filters = new List<String>();

		for (String fieldName : filterMap.keySet()) {
			String expected = 'NULL';
			if (filterMap.get(fieldName) != null) {
				expected = String.valueOf(filterMap.get(fieldName));
			}
			filters.add(fieldName + ' = ' + expected);
		}

		return this.filterBy(filters);
	}

	public RumbleQuery orderBy(String fieldName, String direction) {
		this.orderClauses.add(new OrderClause(fieldName, direction));
		return this;
	}

	public RumbleQuery orderBy(String fieldName) {
		return orderBy(fieldName, 'ASC');
	}

	public RumbleQuery rowLimit(Integer rowLimit) {
		this.rowLimit = String.valueOf(rowLimit);
		return this;
	}

	public RumbleQuery subQuery(RumbleQuery subQuery) {
		this.subQueries.add(subQuery);
		return this;
	}


	public String toSOQL() {
		List<String> queryComponents;
		List<String> selectTokens;
		List<String> filterTokens;
		List<String> orderTokens;

		if (String.isBlank(this.what)) {
			throw new IncompleteQueryException('No Object type specified, unable to build a valid SOQL query!');
		}

		selectTokens = new List<String>();
		selectTokens.addAll(Rumble.FIELD_SUBSCRIPTION.get(this.what));
		for (RumbleQuery subQuery : this.subQueries) {
			selectTokens.add('(' + subQuery.toSOQL() + ')');
		}

		if (selectTokens.size() == 0) {
			throw new IncompleteQueryException('Nothing to select, unable to build a valid SOQL query!');
		}

		filterTokens = new List<String>();
		filterTokens.addAll(this.filters);
		for (String filter : this.filters) {
			filterTokens.add('(' + filter + ')');
		}

		queryComponents = new List<String>();
		queryComponents.add('SELECT');
		queryComponents.add(String.join(selectTokens, ', '));
		queryComponents.add('FROM');
		queryComponents.add(this.what);

		if (this.filters.size() > 0) {
			queryComponents.add('WHERE');
			queryComponents.add(String.join(filterTokens, ' AND '));
		}

		orderTokens = new List<String>();
		for (OrderClause orderClause : this.orderClauses) {
			orderTokens.add(orderClause.toString());
		}
		if (orderTokens.size() > 0) {
			queryComponents.add('ORDER BY');
			queryComponents.add(String.join(orderTokens, ', '));
		}

		if (this.rowLimit != null) {
			queryComponents.add('LIMIT');
			queryComponents.add(String.valueOf(this.rowLimit));
		}

		String soql = String.join(queryComponents, ' ');
		System.debug(LoggingLevel.INFO, 'RumbleQuery:[' + soql + ']');
		return soql;
	}
}
