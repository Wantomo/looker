view: pet {
  sql_table_name: `leafy-habitat-174801.looker.pet`
    ;;
  drill_fields: [pet_id]

  dimension: pet_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.pet_id ;;
  }

  dimension: activity {
    type: number
    sql: ${TABLE}.activity ;;
  }

  dimension: body_type {
    type: number
    sql: ${TABLE}.body_type ;;
  }

  dimension: breed_id {
    type: number
    sql: ${TABLE}.breed_id ;;
  }

  dimension: coat {
    type: number
    sql: ${TABLE}.coat ;;
  }

  dimension_group: completed {
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
    sql: ${TABLE}.completed_at ;;
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

  dimension: digestion {
    type: number
    sql: ${TABLE}.digestion ;;
  }

  dimension_group: dob {
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
    sql: ${TABLE}.dob ;;
  }

  dimension: gender {
    type: number
    sql: ${TABLE}.gender ;;
  }

  dimension: image {
    type: string
    sql: ${TABLE}.image ;;
  }

  dimension: is_accurate_birthday {
    type: number
    sql: ${TABLE}.is_accurate_birthday ;;
  }

  dimension: joint {
    type: number
    sql: ${TABLE}.joint ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: owner_id {
    type: number
    sql: ${TABLE}.owner_id ;;
  }

  dimension: skin {
    type: number
    sql: ${TABLE}.skin ;;
  }

  dimension: snack {
    type: number
    sql: ${TABLE}.snack ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: tear {
    type: number
    sql: ${TABLE}.tear ;;
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

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  dimension: breed_size {
    type: number
    sql: ${TABLE}.breed_size ;;
  }

  dimension: breed_name {
    type: string
    sql: ${TABLE}.breed_name ;;
  }

  measure: count {
    type: count
    drill_fields: [pet_id, name]
  }
}
