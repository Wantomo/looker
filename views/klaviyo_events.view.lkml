view: klaviyo_events {
  sql_table_name: `leafy-habitat-174801.dataform_klaviyo.events`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    link: {
      label: "See details"
      url: "/dashboards-next/29?Email={{ value }}"
    }
  }

  dimension: email_domain {
    type: string
    sql: ${TABLE}.email_domain ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: flow {
    type: string
    sql: ${TABLE}.flow ;;
  }

  dimension: flow_id {
    type: number
    sql: ${TABLE}.flow_id ;;
  }

  dimension: flow_id_system {
    type: string
    sql: ${TABLE}.flow_id_system ;;
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }

  dimension_group: date {
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

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: utm {
    type: string
    sql: ${TABLE}.utm ;;
  }

  measure: count {
    type: count
    drill_fields: [id, email, date_raw, flow]
  }

  measure: unique_user_count {
    label: "Count of Unique Email"
    type: count_distinct
    sql: ${email} ;;
    drill_fields: [id, email, date_raw, flow]
  }

  measure: count_unique_received {
    label: "Count of Unique Received"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "Received Email"]
    drill_fields: [id, email, date_raw, flow]
  }

  measure: count_unique_open {
    label: "Count of Unique Opened"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "Opened Email"]
    drill_fields: [id, email, date_raw, flow]
  }

  measure: count_unique_click {
    label: "Count of Unique Clicked"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "Clicked Email"]
    drill_fields: [id, email, date_raw, flow]
  }

  measure: count_unique_unsubscribed{
    label: "Count of Unique Unsubscribed"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "Unsubscribed"]
    drill_fields: [id, email, date_raw, flow]
  }

}
