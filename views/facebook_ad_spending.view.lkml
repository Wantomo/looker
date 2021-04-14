view: facebook_ad_spending {
  sql_table_name: `leafy-habitat-174801.marketing.facebook_ad_spending`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: ad_name {
    type: string
    sql: ${TABLE}.ad_name ;;
  }

  dimension: ad_sets_name {
    type: string
    sql: ${TABLE}.ad_sets_name ;;
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
    convert_tz: no
  }

  dimension_group: date_stop {
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
    sql: ${TABLE}.date_stop ;;
    convert_tz: no
  }

  dimension: frequency {
    type: number
    sql: ${TABLE}.frequency ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: inline_post_engagements {
    type: number
    sql: ${TABLE}.inline_post_engagements ;;
  }

  dimension: link_clicks {
    type: number
    sql: ${TABLE}.link_clicks ;;
  }

  dimension: reach {
    type: number
    sql: ${TABLE}.reach ;;
  }

  dimension: social_spend {
    type: number
    sql: ${TABLE}.social_spend ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: utm_campaign {
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_term {
    type: string
    sql: ${TABLE}.utm_term ;;
  }

  measure: count {
    type: count
    drill_fields: [id, ad_sets_name, ad_name]
  }

  measure: total_spend {
    type: sum
    sql: ${TABLE}.spend ;;
  }

  measure: total_reach {
    type: sum
    sql: ${TABLE}.reach ;;
  }

  measure: total_impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: total_social_spend {
    type: sum
    sql: ${TABLE}.social_spend ;;
  }

  measure: total_clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: total_link_clicks {
    type: sum
    sql: ${TABLE}.link_clicks ;;
  }

  measure: CTR {
    type: number
    sql: (${total_clicks} / NULLIF(${total_impressions}, 0)) * 100;;
    value_format: "0.00\%"
  }

  measure: CTR_website {
    type: number
    sql: (${total_link_clicks} / NULLIF(${total_impressions}, 0)) * 100;;
    value_format: "0.00\%"
  }

  measure: CPC {
    type: number
    sql: ${total_spend} / NULLIF(${total_clicks}, 0) ;;
    value_format: "0"
  }

  measure: CPC_website {
    type: number
    sql: ${total_spend} / NULLIF(${total_link_clicks}, 0) ;;
    value_format: "0"
  }

  measure: CPM {
    type: number
    sql: (${total_spend} / NULLIF(${total_impressions}, 0)) * 1000;;
    value_format: "0"
  }

  measure: total_inline_post_engagements {
    type: sum
    sql: ${TABLE}.inline_post_engagements ;;
  }

  measure: avg_frequency {
    type: average
    sql: ${TABLE}.frequency ;;
  }
}
