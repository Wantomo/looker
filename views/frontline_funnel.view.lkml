view: frontline_funnel {
  sql_table_name: `leafy-habitat-174801.customer_journey.frontline_funnel`
    ;;

  dimension: bounced {
    type: number
    sql: ${TABLE}.bounced ;;
  }

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

  dimension_group: cart_page_visited {
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
    sql: ${TABLE}.cart_page_visited ;;
    convert_tz: no
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension_group: create_karte_page_visited {
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
    sql: ${TABLE}.create_karte_page_visited ;;
    convert_tz: no
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension: exit_page {
    type: string
    sql: ${TABLE}.exit_page ;;
  }

  dimension: landing_page {
    type: string
    sql: ${TABLE}.landing_page ;;
  }

  dimension_group: order_page_visited {
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
    sql: ${TABLE}.order_page_visited ;;
    convert_tz: no
  }

  dimension: page_views {
    type: number
    sql: ${TABLE}.page_views ;;
  }

  dimension_group: result_page_visited {
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
    sql: ${TABLE}.result_page_visited ;;
    convert_tz: no
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    primary_key: yes
  }

  dimension_group: started {
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
    sql: ${TABLE}.started_at ;;
    convert_tz: no
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: step {
    case: {
      when: {
        label: "LP"
        sql: 1=1 ;;
      }
      when: {
        label: "Karte page"
        sql: 1=1 ;;
      }
      when: {
        label: "Karte Completed"
        sql: 1=1 ;;
      }
      when: {
        label: "Cart"
        sql: 1=1 ;;
      }
      when: {
        label: "Order"
        sql: 1=1 ;;
      }
    }
  }

  measure: count {
    type: count
    drill_fields: [campaign_name]
  }

  measure: count_landing_page {
    type: number
    sql: COUNT(${started_date}) ;;
  }

  measure: count_create_karte_page_visited {
    type: number
    sql: COUNT(${create_karte_page_visited_date}) ;;
  }

  measure: count_result_page_visited {
    type: number
    sql: COUNT(${result_page_visited_date}) ;;
  }

  measure: count_cart_page_visited {
    type: number
    sql: COUNT(${cart_page_visited_date}) ;;
  }

  measure: count_order_page_visited {
    type: number
    sql: COUNT(${order_page_visited_date}) ;;
  }
}
