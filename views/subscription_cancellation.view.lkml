# The name of this view in Looker is "Subscription Cancellation"
view: subscription_cancellation {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `leafy-habitat-174801.dataform_bi.subscription_cancellation`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Count Order" in Explore.

  dimension: count_order {
    type: number
    sql: ${TABLE}.count_order ;;
  }

  dimension: is_resurrected {
    type: yesno
    sql: ${TABLE}.is_resurrected = 1;;
  }

  dimension: order_sequence {
    type: number
    sql: ${TABLE}.order_sequence ;;
  }

  dimension: order_sequence_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${order_sequence} ;;
  }

  dimension_group: unsubscription {
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
    sql: ${TABLE}.unsubscription_date ;;
    convert_tz: no
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: ["user_id"]
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_count_order {
    type: sum
    hidden: yes
    sql: ${count_order} ;;
  }

  measure: average_count_order {
    type: average
    hidden: yes
    sql: ${count_order} ;;
  }

  measure: total_is_resurrected {
    type: sum
    hidden: yes
    sql: ${is_resurrected} ;;
  }

  measure: average_is_resurrected {
    type: average
    hidden: yes
    sql: ${is_resurrected} ;;
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
