view: daily_kpi_targets {
  sql_table_name: `leafy-habitat-174801.marketing.daily_targets_v2`
    ;;

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
    sql: ${TABLE}.Date ;;
  }

  dimension: ad_spending {
    type: number
    sql: ${TABLE}.Ad_spending ;;
  }

  dimension: fl_ad_spending {
    type: number
    sql: ${TABLE}.FL_Ad_spending ;;
  }

  dimension: first_order_count {
    type: number
    sql: ${TABLE}.Order___1st ;;
  }

  dimension: fl_first_order_count {
    type: number
    sql: ${TABLE}.FL_Order___1st ;;
  }

  dimension: first_order_sales {
    type: number
    sql: ${TABLE}.Sales___1st ;;
  }

  dimension: fl_first_order_sales {
    type: number
    sql: ${TABLE}.FL_Sales___1st ;;
  }

  dimension: karte {
    type: number
    sql: ${TABLE}.Karte ;;
  }

  dimension: fl_karte {
    type: number
    sql: ${TABLE}.FL_Karte ;;
  }

  dimension: new_user {
    type: number
    sql: ${TABLE}.Visit ;;
  }

  dimension: fl_new_user {
    type: number
    sql: ${TABLE}.FL_Visit ;;
  }

  dimension: repeat_order_count {
    type: number
    sql: ${TABLE}.Order___Repeat ;;
  }

  dimension: fl_repeat_order_count {
    type: number
    sql: ${TABLE}.FL_Order___Repeat ;;
  }

  dimension: repeat_order_sales {
    type: number
    sql: ${TABLE}.Sales___Repeat ;;
  }

  dimension: fl_repeat_order_sales {
    type: number
    sql: ${TABLE}.FL_Sales___Repeat ;;
  }

  dimension: total_order_count {
    type: number
    sql: ${TABLE}.Order___Total ;;
  }

  dimension: fl_total_order_count {
    type: number
    sql: ${TABLE}.FL_Order___Total ;;
  }

  dimension: total_order_sales {
    type: number
    sql: ${TABLE}.Sales___Total ;;
  }

  dimension: fl_total_order_sales {
    type: number
    sql: ${TABLE}.FL_Sales___Total ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum_first_order_count {
    type: sum
    sql: ${first_order_count} ;;
  }

  measure: sum_fl_first_order_count {
    type: sum
    sql: ${fl_first_order_count} ;;
  }

  measure: sum_first_order_sales {
    type: sum
    sql: ${first_order_sales} ;;
  }

  measure: sum_fl_first_order_sales {
    type: sum
    sql: ${fl_first_order_sales} ;;
  }

  measure: sum_karte {
    type: sum
    sql: ${karte} ;;
  }

  measure: sum_fl_karte {
    type: sum
    sql: ${fl_karte} ;;
  }

  measure: sum_new_user {
    type: sum
    sql: ${new_user} ;;
  }

  measure: sum_fl_new_user {
    type: sum
    sql: ${fl_new_user} ;;
  }

  measure: sum_repeat_order_count {
    type: sum
    sql: ${repeat_order_count} ;;
  }

  measure: sum_fl_repeat_order_count {
    type: sum
    sql: ${fl_repeat_order_count} ;;
  }

  measure: sum_total_order_count {
    type: sum
    sql: ${total_order_count} ;;
  }

  measure: sum_fl_total_order_count {
    type: sum
    sql: ${fl_total_order_count} ;;
  }

  measure: sum_total_order_sales {
    type: sum
    sql: ${total_order_sales} ;;
  }

  measure: sum_fl_total_order_sales {
    type: sum
    sql: ${fl_total_order_sales} ;;
  }

  measure: sum_ad_spending {
    type: sum
    sql: ${ad_spending} ;;
  }

  measure: sum_fl_ad_spending {
    type: sum
    sql: ${fl_ad_spending} ;;
  }
}
