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
    convert_tz: no
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
    convert_tz: no
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
    convert_tz: no
  }

  dimension: is_sterilized {
    type: yesno
    sql:  ${TABLE}.gender = 3 OR ${TABLE}.gender = 4  ;;
  }

  dimension: gender {
    type: string
    sql:  CASE
              WHEN ${TABLE}.gender = 1 THEN 'Girl'
              WHEN ${TABLE}.gender = 2 THEN 'Boy'
              WHEN ${TABLE}.gender = 3 THEN 'Girl'
              WHEN ${TABLE}.gender = 4 THEN 'Boy'
          END ;;
  }

  dimension: age {
    type: duration_year
    sql_start: TIMESTAMP(DATETIME(TIMESTAMP_MILLIS(CAST(SUBSTR(SAFE_CAST(UNIX_MILLIS(${TABLE}.dob) AS string),1,13) AS int64)))) ;;
    sql_end: CURRENT_TIMESTAMP() ;;
  }

  dimension: age_group {
    type: string
    sql:  CASE
              WHEN ${age} < 1 THEN 'Puppy'
              WHEN ${age} < 7 THEN 'Adult'
              ELSE 'Senior'
          END ;;
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
    drill_fields: [pet_id]
  }

  measure: avg_weight {
    type: average
    sql: ${weight} ;;
    drill_fields: [pet_id]
  }

  measure: mdn_weight {
    type: median
    sql: ${weight} ;;
    drill_fields: [pet_id]
  }

  measure: avg_age {
    type: average
    sql: ${age} ;;
    drill_fields: [pet_id]
  }

  measure: mdn_age {
    type: median
    sql: ${age} ;;
    drill_fields: [pet_id]
  }
}
