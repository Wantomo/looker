view: daily_kpi_targets {
  sql_table_name: `leafy-habitat-174801.looker.daily_kpi_targets`
    ;;

  dimension: ad_spending {
    type: number
    sql: ${TABLE}.ad_spending ;;
  }

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

  dimension: first_order_count {
    type: number
    sql: ${TABLE}.first_order_count ;;
  }

  dimension: first_order_sales {
    type: number
    sql: ${TABLE}.first_order_sales ;;
  }

  dimension: karte {
    type: number
    sql: ${TABLE}.karte ;;
  }

  dimension: new_user {
    type: number
    sql: ${TABLE}.new_user ;;
  }

  dimension: repeat_order_count {
    type: number
    sql: ${TABLE}.repeat_order_count ;;
  }

  dimension: repeat_order_sales {
    type: number
    sql: ${TABLE}.repeat_order_sales ;;
  }

  dimension: total_order_count {
    type: number
    sql: ${TABLE}.total_order_count ;;
  }

  dimension: total_order_sales {
    type: number
    sql: ${TABLE}.total_order_sales ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum {
    type: sum
  }

  measure: sum_first_order_count {
    type: sum
    sql: ${TABLE}.first_order_count ;;
  }

  measure: sum_first_order_sales {
    type: sum
    sql: ${TABLE}.first_order_sales ;;
  }

  measure: sum_karte {
    type: sum
    sql: ${TABLE}.karte ;;
  }

  measure: sum_new_user {
    type: sum
    sql: ${TABLE}.new_user ;;
  }

  measure: sum_repeat_order_count {
    type: sum
    sql: ${TABLE}.repeat_order_count ;;
  }

  measure: sum_total_order_count {
    type: sum
    sql: ${TABLE}.total_order_count ;;
  }

  measure: sum_total_order_sales {
    type: sum
    sql: ${TABLE}.total_order_sales ;;
  }

  measure: sum_ad_spending {
    type: sum
    sql: ${TABLE}.ad_spending ;;
  }
}
