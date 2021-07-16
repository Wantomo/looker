view: customer_facts {
  sql_table_name: `leafy-habitat-174801.dataform_bi.customer_facts`
    ;;

  dimension: average_date_diff {
    type: number
    sql: ${TABLE}.average_date_diff ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    primary_key: yes
  }

  dimension: first_order_id {
    type: string
    sql: ${TABLE}.first_order_id ;;
  }

  dimension_group: first_purchase {
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
    sql: ${TABLE}.first_purchase_date ;;
    convert_tz: no
  }

  dimension: first_purchase_date_diff_day {
    type: number
    sql: ${TABLE}.first_purchase_date_diff_day ;;
  }

  dimension: first_purchase_date_diff_hour {
    type: number
    sql: ${TABLE}.first_purchase_date_diff_hour ;;
  }

  dimension: first_purchase_is_subscription {
    type: yesno
    sql: ${TABLE}.first_purchase_is_subscription = 1;;
  }

  dimension: first_purchase_has_discount {
    type: yesno
    sql: ${TABLE}.first_purchase_has_discount = 1;;
  }

  dimension: first_purchase_has_50_percent {
    type: yesno
    sql: ${TABLE}.first_purchase_has_50_percent = 1;;
  }

  dimension: last_order_id {
    type: string
    sql: ${TABLE}.last_order_id ;;
  }

  dimension_group: last_purchase {
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
    sql: ${TABLE}.last_purchase_date ;;
    convert_tz: no
  }

  dimension: last_purchase_is_subscription {
    type: yesno
    sql: ${TABLE}.last_purchase_is_subscription = 1;;
  }

  dimension: lifetime_sales {
    type: number
    sql: ${TABLE}.lifetime_sales ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: second_order_id {
    type: string
    sql: ${TABLE}.second_order_id ;;
  }

  dimension_group: second_purchase {
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
    sql: ${TABLE}.second_purchase_date ;;
    convert_tz: no
  }

  dimension: second_purchase_date_diff_day {
    type: number
    sql: ${TABLE}.second_purchase_date_diff_day ;;
  }

  dimension: second_purchase_has_discount {
    type: yesno
    sql: ${TABLE}.second_purchase_has_discount = 1;;
  }

  dimension: second_purchase_is_subscription {
    type: yesno
    sql: ${TABLE}.second_purchase_is_subscription = 1;;
  }

  dimension: third_order_id {
    type: string
    sql: ${TABLE}.third_order_id ;;
  }

  dimension_group: third_purchase {
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
    sql: ${TABLE}.third_purchase_date ;;
    convert_tz: no
  }

  dimension: third_purchase_date_diff_day {
    type: number
    sql: ${TABLE}.third_purchase_date_diff_day ;;
  }

  dimension: third_purchase_is_subscription {
    type: yesno
    sql: ${TABLE}.third_purchase_is_subscription = 1;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
