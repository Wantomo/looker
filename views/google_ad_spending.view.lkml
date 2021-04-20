view: google_ad_spending {
  sql_table_name: `leafy-habitat-174801.marketing.google_ad_spending`
    ;;

  dimension: budget {
    type: number
    sql: ${TABLE}.budget ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension_group: date_start {
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
    sql: ${TABLE}.date_start ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: interactions {
    type: number
    sql: ${TABLE}.interactions ;;
  }

  dimension: invalid_clicks {
    type: number
    sql: ${TABLE}.invalid_clicks ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: utm_term {
    type: string
    sql: ${TABLE}.utm_term ;;
  }

  measure: total_spend {
    type: sum
    sql: ${TABLE}.budget ;;
  }

  measure: total_impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: total_clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: total_interactions {
    type: sum
    sql: ${TABLE}.interactions ;;
  }

  measure: CTR {
    type: number
    sql: (${total_clicks} / NULLIF(${total_impressions}, 0)) * 100;;
    value_format: "0.00\%"
  }

  measure: CPC {
    type: number
    sql: ${total_spend} / NULLIF(${total_clicks}, 0) ;;
    value_format: "0"
  }

  measure: CPM {
    type: number
    sql: (${total_spend} / NULLIF(${total_impressions}, 0)) * 1000;;
    value_format: "0"
  }
}
