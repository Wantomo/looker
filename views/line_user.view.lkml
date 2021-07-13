view: line_user {
  sql_table_name: `leafy-habitat-174801.dataform_line.user`
    ;;
  drill_fields: [user_id]

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: is_active {
    type: yesno
    sql: CAST(${TABLE}.is_active AS BOOLEAN) = true ;;
  }

  dimension: is_linked_user {
    type: yesno
    sql:  ${user_id} IS NOT NULL ;;
  }

  dimension: line_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.line_id ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [user_id]
  }
}
