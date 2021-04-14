view: ga_daily_users {
  sql_table_name: `leafy-habitat-174801.looker.ga_daily_users`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: avgsessionduration {
    type: string
    sql: ${TABLE}.ga_avgsessionduration ;;
  }

  dimension: bouncerate {
    type: number
    sql: ${TABLE}.ga_bouncerate ;;
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
    sql: ${TABLE}.ga_date ;;
    convert_tz: no
  }

  dimension: newusers {
    type: number
    sql: ${TABLE}.ga_newusers ;;
  }

  dimension: pageviews {
    type: number
    sql: ${TABLE}.ga_pageviews ;;
  }

  dimension: pageviewspersession {
    type: number
    sql: ${TABLE}.ga_pageviewspersession ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.ga_sessions ;;
  }

  dimension: sessionsperuser {
    type: number
    sql: ${TABLE}.ga_sessionsperuser ;;
  }

  dimension: users {
    type: number
    sql: ${TABLE}.ga_users ;;
  }

  measure: count_users {
    label: "Count of users"
    type: sum_distinct
    sql: ${users} ;;
  }

  measure: count_new_users {
    label: "Count of new users"
    type: sum_distinct
    sql: ${newusers} ;;
  }
}
