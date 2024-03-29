view: sessionized_pages {
  sql_table_name: `leafy-habitat-174801.dataform_segment.sessionized_pages`
    ;;

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}.anonymous_id ;;
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

  dimension: context_ip {
    type: string
    sql: ${TABLE}.context_ip ;;
  }

  dimension: has_ordered {
    type: number
    sql: ${TABLE}.has_ordered ;;
  }

  dimension: page_id {
    type: string
    sql: ${TABLE}.page_id ;;
    primary_key: yes
  }

  dimension: page_index {
    type: number
    sql: ${TABLE}.page_index ;;
  }

  dimension: page_path {
    type: string
    sql: ${TABLE}.page_path ;;
  }

  dimension: page_url {
    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: referrer {
    type: string
    sql: ${TABLE}.referrer ;;
  }

  dimension: session_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: session_index {
    type: number
    sql: ${TABLE}.session_index ;;
  }

  dimension: time_spent {
    type: number
    sql: ${TABLE}.time_spent ;;
  }

  dimension_group: timestamp {
    label: "Date"
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
    sql: ${TABLE}.timestamp ;;
    convert_tz: no
  }

  dimension: user_agent {
    type: string
    sql: ${TABLE}.user_agent ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }

  measure: count {
    label: "Page views"
    type: count
    drill_fields: [timestamp_time,user_id,session_id]
  }

  measure: unique_user_count {
    label: "Visitors"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [timestamp_time,user_id,session_id]
  }

  measure: unique_session_count {
    label: "Sessions"
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [timestamp_time,user_id,session_id]
  }


  measure: unique_new_user_count {
    label: "New Visitors"
    type: count_distinct
    sql: CASE WHEN ${session_index} = 1 THEN ${user_id} ELSE null
      END ;;
  }

  measure: unique_repeat_user_count {
    label: "Returning Visitors"
    type: count_distinct
    sql: CASE WHEN ${session_index} > 1 THEN ${user_id} ELSE null
      END ;;
  }
}
