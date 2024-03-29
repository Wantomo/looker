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
    convert_tz: no
  }

  dimension: has_ordered {
    type: number
    sql: ${TABLE}.has_ordered ;;
  }

  dimension: last_page {
    type: string
    sql: ${TABLE}.last_page ;;
  }

  dimension: order_sequence_food {
    description: "Sequence of food order"
    type: number
    sql: ${TABLE}.order_sequence_food ;;
  }

  dimension: order_sequence_food_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${order_sequence_food} ;;
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
    convert_tz: no
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    label: "Sessions"
    type: count
    drill_fields: [session_id, campaign_name]
  }

  measure: total_page_views {
    label: "Page views"
    type: sum
    sql: ${page_views} ;;
  }

  measure: average_page_views {
    label: "Average Pages / Session"
    type: number
    sql: SUM(${page_views}) / count(${session_id}) ;;
    value_format: "0.##"
  }

  measure: average_session_per_users {
    label: "Number of Sessions per User"
    type: number
    sql: count(${session_id}) / count(distinct(${user_id})) ;;
    value_format: "0.##"
  }

  measure: average_session_duration {
    label: "Avg. Session Duration"
    type: average
    sql: ${duration} ;;
    value_format: "0"
    html: {{ rendered_value | date: "%T" }};;
  }

  measure: bounces {
    label: "Bounces"
    type: number
    sql: SUM(CASE WHEN ${bounced} = 1 THEN 1 ELSE 0 END);;
  }

  measure: bounce_rate {
    label: "Bounce Rate"
    type: number
    sql:SUM(CASE WHEN ${bounced} = 1 THEN 1 ELSE 0
    END) / count(${session_id});;
    value_format: "0.00%"
  }

  measure: unique_user_count {
    label: "Visitors"
    type: count_distinct
    sql: ${user_id} ;;
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
