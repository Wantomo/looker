view: pet {
  sql_table_name: `leafy-habitat-174801.looker.pet`
    ;;
  drill_fields: [pet_id]

  dimension: pet_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.pet_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/33?Pet%20ID={{ value }}"
    }
  }

  dimension: activity {
    type: string
    description: "Level of activity"
    sql: CASE
          WHEN ${TABLE}.activity = 0.90 THEN 'A little'
          WHEN ${TABLE}.activity = 1.00 THEN 'Normal'
          WHEN ${TABLE}.activity = 1.10 THEN 'A lot'
        END ;;
  }

  dimension: body_type {
    type: string
    sql: CASE
          WHEN ${TABLE}.body_type = 2 THEN 'Thin'
          WHEN ${TABLE}.body_type = 3 THEN 'Normal'
          WHEN ${TABLE}.body_type = 4 THEN 'Overweight'
        END ;;
  }

  dimension: breed_id {
    type: number
    sql: ${TABLE}.breed_id ;;
  }

  dimension: coat {
    label: "Coat Issue"
    type: string
    sql: CASE
          WHEN ${TABLE}.coat = 0 THEN 'Normal'
          WHEN ${TABLE}.coat = 1 THEN 'Not good'
        END ;;
  }

  dimension_group: completed {
    description: "Date of completion of a pet"
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
    description: "Date of when a pet was started to be created (after registration)"
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
    label: "Digestion Issue"
    type: string
    sql: CASE
          WHEN ${TABLE}.digestion = 0 THEN 'Normal'
          WHEN ${TABLE}.digestion = 1 THEN 'Constipation'
          WHEN ${TABLE}.digestion = 2 THEN 'Too much poop'
        END ;;
  }

  dimension_group: dob {
    label: "Birth Date"
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
              WHEN ${TABLE}.gender IN (1, 3) THEN 'Girl'
              WHEN ${TABLE}.gender IN (2, 4) THEN 'Boy'
          END ;;
  }

  dimension: age {
    type: duration_year
    sql_start: TIMESTAMP(DATETIME(TIMESTAMP_MILLIS(CAST(SUBSTR(SAFE_CAST(UNIX_MILLIS(${TABLE}.dob) AS string),1,13) AS int64)))) ;;
    sql_end: CURRENT_TIMESTAMP() ;;
  }

  dimension: age_group {
    type: string
    description: "Age < 1y = Puppy / Age < 7y = Adult"
    sql:  CASE
              WHEN ${age} < 1 THEN 'Puppy'
              WHEN ${age} < 7 THEN 'Adult'
              ELSE 'Senior'
          END ;;
  }

  dimension: image {
    type: string
    link: {
      label: "Image"
      url: "https://cdn-media.leoandlea.com/{{ value }}"
    }
    sql: ${TABLE}.image ;;
  }

  dimension: image_full {
    type: string
    link: {
      label: "Image"
      url: "{{ value }}"
    }
    sql: concat('https://cdn-media.leoandlea.com/', ${TABLE}.image) ;;
  }

  dimension: is_accurate_birthday {
    type: yesno
    sql: ${TABLE}.is_accurate_birthday = 1;;
  }

  dimension: joint {
    label: "Joint Issue"
    type: string
    sql: CASE
          WHEN ${TABLE}.joint = 0 THEN 'Normal'
          WHEN ${TABLE}.joint = 1 THEN 'Not good'
        END ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: owner_id {
    type: number
    sql: ${TABLE}.owner_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/29?Customer%20ID={{ value }}"
    }
  }

  dimension: skin {
    label: "Skin Issue"
    type: string
    sql: CASE
          WHEN ${TABLE}.skin = 0 THEN 'Normal'
          WHEN ${TABLE}.skin = 1 THEN 'Dry'
          WHEN ${TABLE}.skin = 2 THEN 'Oily'
        END ;;
  }

  dimension: snack {
    type: string
    sql: CASE
          WHEN ${TABLE}.snack = 0 THEN 'No'
          WHEN ${TABLE}.snack = 1 THEN 'Sometimes'
          WHEN ${TABLE}.snack = 2 THEN 'Yes'
        END ;;
  }

  dimension: status {
    type: string
    sql: CASE
          WHEN ${TABLE}.status = 0 THEN 'Processing'
          WHEN ${TABLE}.status = 1 THEN 'Active'
          WHEN ${TABLE}.status = 2 THEN 'Disabled'
          WHEN ${TABLE}.status = 3 THEN 'Past Away'
        END ;;
  }

  dimension: tear {
    label: "Tear Issue"
    type: string
    sql: CASE
          WHEN ${TABLE}.tear = 0 THEN 'Normal'
          WHEN ${TABLE}.tear = 1 THEN 'Not good'
        END ;;
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
    type: string
    sql: CASE
          WHEN ${TABLE}.breed_size = 1 THEN 'Small'
          WHEN ${TABLE}.breed_size = 2 THEN 'Medium'
          WHEN ${TABLE}.breed_size = 3 THEN 'Large'
        END ;;
  }

  dimension: breed_name {
    type: string
    sql: ${TABLE}.breed_name ;;
  }

  dimension: service {
    label: "Service type"
    description: "Food (= 1)/frontline (= 2)"
    type: string
    sql:  CASE
            WHEN ${TABLE}.service = 2 THEN 'Frontline'
            ELSE 'Food'
          END ;;
  }

  measure: count {
    type: count
    drill_fields: [pet_id]
  }

  measure: count_unique {
    type: count_distinct
    sql: ${owner_id} ;;
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
