view: food_funnel_first_visit {
  sql_table_name: `leafy-habitat-174801.customer_journey.food_funnel_first_visit`
    ;;

  dimension: campaign_medium {
    type: string
    sql: ${TABLE}.campaign_medium ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_source {
    type: string
    sql: ${TABLE}.campaign_source ;;
  }

  dimension: campaign_term {
    type: string
    sql: ${TABLE}.campaign_term ;;
  }

  dimension_group: cart {
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
    sql: ${TABLE}.cart_date ;;
    convert_tz: no
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension_group: create_karte {
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
    sql: ${TABLE}.create_karte_date ;;
    convert_tz: no
  }

  dimension_group: create_karte_step_2 {
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
    sql: ${TABLE}.create_karte_step_2_date ;;
    convert_tz: no
  }

  dimension_group: first_visit {
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
    sql: ${TABLE}.first_visit ;;
    convert_tz: no
  }

  dimension_group: karte_result {
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
    sql: ${TABLE}.karte_result_date ;;
    convert_tz: no
  }

  dimension: landing_page {
    type: string
    sql: ${TABLE}.landing_page ;;
  }

  dimension_group: lead {
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
    sql: ${TABLE}.lead_date ;;
    convert_tz: no
  }

  dimension: referrer {
    type: string
    sql: ${TABLE}.referrer ;;
  }

  dimension_group: sales_order {
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
    sql: ${TABLE}.sales_order_date ;;
    convert_tz: no
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: date_diff_day {
    type: number
    label: "By Day"
    group_label: "Difference"
    sql: date_diff(${sales_order_date},${first_visit_date}, DAY) ;;
  }

  dimension: datetime_diff_day {
    type: number
    label: "By Hour"
    group_label: "Difference"
    sql: TIMESTAMP_DIFF(${TABLE}.sales_order_date,${TABLE}.first_visit, HOUR) ;;
  }

  dimension: datetime_karte_diff_day {
    type: number
    label: "Karte By Minute"
    group_label: "Difference"
    sql: TIMESTAMP_DIFF(${TABLE}.karte_result_date,${TABLE}.create_karte_date, MINUTE) ;;
  }

  measure: count {
    type: count
    drill_fields: [campaign_name]
  }

  measure: average_datetime_karte_diff {
    type: median
    sql: ${datetime_karte_diff_day} ;;
  }

  measure: count_landing_page {
    type: number
    sql: COUNT(${first_visit_date}) ;;
  }

  measure: count_create_karte {
    type: number
    sql: COUNT(${create_karte_date}) ;;
  }

  measure: count_create_karte_step_2 {
    type: number
    sql: COUNT(${create_karte_step_2_date}) ;;
  }

  measure: count_lead {
    type: number
    sql: COUNT(${lead_date}) ;;
  }

  measure: count_karte_result {
    type: number
    sql: COUNT(${karte_result_date}) ;;
  }

  measure: count_cart {
    type: number
    sql: COUNT(${cart_date}) ;;
  }

  measure: count_order {
    type: number
    sql: COUNT(${sales_order_date}) ;;
  }
}
