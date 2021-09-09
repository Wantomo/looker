# The name of this view in Looker is "Sales Sequence"
view: sales_sequence {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `leafy-habitat-174801.dataform_bi.sales_sequence`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: churn {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.churn_date ;;
    convert_tz: no
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Churn Group" in Explore.

  dimension: churn_group {
    type: number
    sql: ${TABLE}.churn_group ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Churn Group" in Explore.

  dimension: churn_group_name {
    type: number
    sql:  CASE
            WHEN ${churn_group} = 1 THEN 'Low (+30d)'
            WHEN ${churn_group} = 2 THEN 'Medium (+60d)'
            WHEN ${churn_group} = 3 THEN 'High (+90d)'
            WHEN ${churn_group} = 4 THEN 'Very High (+150d)'
            WHEN ${churn_group} = 5 THEN 'Sayonara (+270d)'
            ELSE 'Not churned'
          END;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    convert_tz: no
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: date_diff {
    type: number
    sql: ${TABLE}.date_diff ;;
  }

  dimension: entity_id {
    type: number
    sql: ${TABLE}.entity_id ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_order_date ;;
    convert_tz: no
  }

  dimension_group: next_order {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.next_order_date ;;
    convert_tz: no
  }

  dimension: order_sequence {
    type: number
    sql: ${TABLE}.order_sequence ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: []
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_churn_group {
    type: sum
    hidden: yes
    sql: ${churn_group} ;;
  }

  measure: average_churn_group {
    type: average
    hidden: yes
    sql: ${churn_group} ;;
  }

  measure: total_date_diff {
    type: sum
    hidden: yes
    sql: ${date_diff} ;;
  }

  measure: average_date_diff {
    type: average
    hidden: yes
    sql: ${date_diff} ;;
  }

  measure: total_order_sequence {
    type: sum
    hidden: yes
    sql: ${order_sequence} ;;
  }

  measure: average_order_sequence {
    type: average
    hidden: yes
    sql: ${order_sequence} ;;
  }
}
