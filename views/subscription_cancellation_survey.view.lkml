# The name of this view in Looker is "Subscription Cancellation Survey"
view: subscription_cancellation_survey {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `leafy-habitat-174801.dataform_bi.subscription_cancellation_survey`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cancellation Reason Number" in Explore.

  dimension: cancellation_reason_number {
    type: number
    sql: ${TABLE}.cancellation_reason_number ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cancellation_reason_number {
    type: sum
    sql: ${cancellation_reason_number} ;;
  }

  measure: average_cancellation_reason_number {
    type: average
    sql: ${cancellation_reason_number} ;;
  }

  dimension: cancellation_reason_text {
    type: string
    sql: ${TABLE}.cancellation_reason_text ;;
  }

  dimension: has_unsubscribed {
    type: yesno
    sql: ${TABLE}.has_unsubscribed ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: timestamp {
    type: time
    timeframes: [
      hour_of_day,
      day_of_week,
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.timestamp ;;
    convert_tz: no
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/29?Customer%20ID={{ value }}"
    }
  }

  measure: count {
    type: count
    drill_fields: [user_id]
  }
}
