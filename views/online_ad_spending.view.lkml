view: online_ad_spending {
  sql_table_name: `leafy-habitat-174801.looker.online_ad_spending`
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
    sql: ${TABLE}.date ;;
  }

  dimension: facebook {
    type: number
    sql: ${TABLE}.facebook ;;
  }

  dimension: google {
    type: number
    sql: ${TABLE}.google ;;
  }

  dimension: line {
    type: number
    sql: ${TABLE}.line ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  dimension: yahoo {
    type: number
    sql: ${TABLE}.yahoo ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum_total {
    type: sum
    sql: ${TABLE}.total ;;
  }

  measure: sum_facebook {
    type: sum
    sql: ${TABLE}.facebook ;;
  }

  measure: sum_google {
    type: sum
    sql: ${TABLE}.google ;;
  }

  measure: sum_yahoo {
    type: sum
    sql: ${TABLE}.yahoo ;;
  }

  measure: sum_line {
    type: sum
    sql: ${TABLE}.line ;;
  }
}
