view: funnel_first_visit {
  sql_table_name: `leafy-habitat-174801.customer_journey.funnel_first_visit`
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

  dimension_group: cart_viewed {
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
    sql: ${TABLE}.first_cart_viewed_date_ts ;;
  }

  dimension_group: create_karte_viewed {
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
    sql: ${TABLE}.first_create_karte_viewed_date_ts ;;
  }

  dimension_group: karte_created {
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
    sql: ${TABLE}.first_karte_date_ts ;;
  }

  dimension_group: lead_completed {
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
    sql: ${TABLE}.first_lead_date_ts ;;
  }

  dimension_group: order_completed {
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
    sql: ${TABLE}.first_order_date_ts ;;
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
    sql: ${TABLE}.first_visit_ts ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
  }

  measure: count_cart_viewed {
    type: number
    sql: COUNT(${cart_viewed_date}) ;;
  }

  measure: count_create_karte_viewed {
    type: number
    sql: COUNT(${create_karte_viewed_date}) ;;
  }

  measure: count_karte_created {
    type: number
    sql: COUNT(${karte_created_date}) ;;
  }

  measure: count_lead_completed {
    type: number
    sql: COUNT(${lead_completed_date}) ;;
  }

  measure: count_order_completed {
    type: number
    sql: COUNT(${order_completed_date}) ;;
  }

  measure: count_first_visit {
    type: number
    sql: COUNT(${first_visit_date}) ;;
  }
}
