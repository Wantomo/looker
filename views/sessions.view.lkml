view: sessions {
  sql_table_name: `leafy-habitat-174801.dataform_segment.sessions`
    ;;
  drill_fields: [session_id]

  dimension: session_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: bounced {
    type: number
    sql: ${TABLE}.bounced ;;
  }

  dimension: campaign_content {
    type: string
    sql: ${TABLE}.campaign_content ;;
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

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension_group: finished {
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
    sql: ${TABLE}.finished_at ;;
  }

  dimension: has_ordered {
    type: number
    sql: ${TABLE}.has_ordered ;;
  }

  dimension: last_page {
    type: string
    sql: ${TABLE}.last_page ;;
  }

  dimension: page_1 {
    type: string
    sql: ${TABLE}.page_1 ;;
  }

  dimension: page_2 {
    type: string
    sql: ${TABLE}.page_2 ;;
  }

  dimension: page_3 {
    type: string
    sql: ${TABLE}.page_3 ;;
  }

  dimension: page_4 {
    type: string
    sql: ${TABLE}.page_4 ;;
  }

  dimension: page_5 {
    type: string
    sql: ${TABLE}.page_5 ;;
  }

  dimension: page_views {
    type: number
    sql: ${TABLE}.page_views ;;
  }

  dimension: session_index {
    type: number
    sql: ${TABLE}.session_index ;;
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
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [session_id, campaign_name, sessionized_pages.count]
  }
}
