# The name of this view in Looker is "Rich Menu Analytics"
view: rich_menu_analytics {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `leafy-habitat-174801.dataform_line.rich_menu_analytics`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Link Count" in Explore.

  dimension: account_link_count {
    type: number
    sql: ${TABLE}.account_link_count ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_account_link_count {
    type: sum
    sql: ${account_link_count} ;;
  }

  measure: average_account_link_count {
    type: average
    sql: ${account_link_count} ;;
  }

  dimension: campaign_count {
    type: number
    sql: ${TABLE}.campaign_count ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: delivery_count {
    type: number
    sql: ${TABLE}.delivery_count ;;
  }

  dimension: my_page_count {
    type: number
    sql: ${TABLE}.my_page_count ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
