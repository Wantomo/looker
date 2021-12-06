view: last_touch_utm {
  sql_table_name: `leafy-habitat-174801.dataform_segment.last_touch_utm`
    ;;

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

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: entity_id {
    type: number
    sql: ${TABLE}.entity_id ;;
    primary_key: yes
  }

  dimension: increment_id {
    type: string
    sql: ${TABLE}.increment_id ;;
  }

  dimension: is_subscription {
    label: "Is Subscription Order"
    type: yesno
    sql: ${TABLE}.is_subscription = 1 ;;
  }

  dimension_group: order_date {
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
    sql: ${TABLE}.order_date ;;
    convert_tz: no
  }

  dimension: order_revenue {
    type: number
    sql: ${TABLE}.order_revenue ;;
  }

  measure: count {
    type: count_distinct
    sql: ${entity_id} ;;
    drill_fields: [increment_id, entity_id, customer_id, campaign_name]
  }

  measure: total_sales {
    type: sum_distinct
    sql_distinct_key: ${entity_id} ;;
    sql: ${order_revenue} ;;
    drill_fields: [increment_id, entity_id, customer_id, campaign_name]
  }
}
