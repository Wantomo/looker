view: pet {
  sql_table_name: `leafy-habitat-174801.looker.pet`
    ;;
  drill_fields: [pet_id]

  dimension: activity {
    type: string
    description: "Level of activity"
    sql: CASE
          WHEN ${TABLE}.activity = 0.90 THEN 'A little'
          WHEN ${TABLE}.activity = 1.00 THEN 'Normal'
          WHEN ${TABLE}.activity = 1.10 THEN 'A lot'
        END ;;
  }

  dimension: activity_coefficient {
    type: number
    sql: ${TABLE}.activity ;;
  }

  dimension: age {
    type: duration_year
    sql_start: TIMESTAMP(DATETIME(TIMESTAMP_MILLIS(CAST(SUBSTR(SAFE_CAST(UNIX_MILLIS(${TABLE}.dob) AS string),1,13) AS int64)))) ;;
    sql_end: CURRENT_TIMESTAMP() ;;
  }

  dimension: age_month {
    type: duration_month
    sql_start: TIMESTAMP(DATETIME(TIMESTAMP_MILLIS(CAST(SUBSTR(SAFE_CAST(UNIX_MILLIS(${TABLE}.dob) AS string),1,13) AS int64)))) ;;
    sql_end: CURRENT_TIMESTAMP() ;;
  }

  dimension: age_coefficient {
    type: number
    sql: CASE
              WHEN ${age_group} = 'Senior' AND ${is_sterilized} = false THEN 1.4
              WHEN ${age_group} = 'Senior' AND ${is_sterilized} = true THEN 1.3
              WHEN ${age_group} = 'Adult' AND ${is_sterilized} = false THEN 1.6
              WHEN ${age_group} = 'Adult' AND ${is_sterilized} = true THEN 1.4
              WHEN ${age_group} = 'Puppy' AND ${age_month} in (0,1,2,3) THEN 4.0
              WHEN ${age_group} = 'Puppy' AND ${age_month} in (4,5,6,7,8) THEN 3.0
              WHEN ${age_group} = 'Puppy' AND ${is_sterilized} = false AND ${age_month} in (9,10,11) THEN 2.0
              WHEN ${age_group} = 'Puppy' AND ${is_sterilized} = true AND ${age_month} in (9,10,11) THEN 1.8
          END ;;
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

  dimension: body_type {
    type: string
    sql: CASE
          WHEN ${TABLE}.body_type = 2 THEN 'Thin'
          WHEN ${TABLE}.body_type = 3 THEN 'Normal'
          WHEN ${TABLE}.body_type = 4 THEN 'Overweight'
        END ;;
  }

  dimension: body_type_coefficient {
    type: number
    sql: CASE
          WHEN ${TABLE}.body_type = 2 THEN 0.90
          WHEN ${TABLE}.body_type = 3 THEN 1.00
          WHEN ${TABLE}.body_type = 4 THEN 1.15
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

  dimension: gender {
    type: string
    sql:  CASE
              WHEN ${TABLE}.gender IN (1, 3) THEN 'Girl'
              WHEN ${TABLE}.gender IN (2, 4) THEN 'Boy'
          END ;;
  }

  dimension: gram_beef {
    label: "Daily Gram Beef"
    type: number
    sql: FLOOR(((${kcal_raw} / ${recipe_beef_kcal}) * 100) * ${snack_coefficient});;
  }

  dimension: gram_chicken {
    label: "Daily Gram Chicken"
    type: number
    sql: FLOOR(((${kcal_raw} / ${recipe_chicken_kcal}) * 100) * ${snack_coefficient});;
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

  dimension: is_sterilized {
    type: yesno
    sql:  ${TABLE}.gender = 3 OR ${TABLE}.gender = 4  ;;
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

  dimension: kcal {
    type: number
    label: "Daily Kcal"
    sql: CAST(ROUND((70 * (POWER((${weight} / ${body_type_coefficient}),0.75))) * ${age_coefficient} * ${activity_coefficient}, 3) AS INT64);;
  }

  dimension: kcal_raw {
    type: number
    label: "Daily Kcal RAW"
    sql: ROUND((70 * (POWER((${weight} / ${body_type_coefficient}),0.75))) * ${age_coefficient} * ${activity_coefficient}, 3) ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: name_honorific {
    type: string
    sql: CASE
          WHEN ${gender} = 'Girl' THEN CONCAT(${name}, 'ちゃん')
          WHEN ${gender} = 'Boy' THEN CONCAT(${name}, 'くん')
        END ;;
  }

  dimension: owner_id {
    type: number
    sql: ${TABLE}.owner_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/29?Customer%20ID={{ value }}"
    }
  }

  dimension: percentage_calory_intake {
    type: string
    sql: CASE
          WHEN ${snack} = 'No' THEN '100%'
          ELSE '90%'
        END ;;
  }

  dimension: pet_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.pet_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/33?Pet%20ID={{ value }}"
    }
  }

  dimension: recipe_beef_code {
    type: string
    sql: CASE
          WHEN ${age_group} = 'Puppy' THEN 'BP01'
          WHEN ${age_group} = 'Adult' THEN 'BA01'
          WHEN ${age_group} = 'Senior' THEN 'BS01'
        END ;;
  }

  dimension:recipe_beef_kcal {
    type: number
    sql: CASE
          WHEN ${age_group} = 'Puppy' THEN 402
          WHEN ${age_group} = 'Adult' THEN 371
          WHEN ${age_group} = 'Senior' THEN 372
        END ;;
  }

  dimension: recipe_chicken_code  {
    type: string
    sql: CASE
          WHEN ${age_group} = 'Puppy' THEN 'CP01'
          WHEN ${age_group} = 'Adult' THEN 'CA01'
          WHEN ${age_group} = 'Senior' THEN 'CS01'
        END ;;
  }

  dimension:recipe_chicken_kcal {
    type: number
    sql: CASE
          WHEN ${age_group} = 'Puppy' THEN 418
          WHEN ${age_group} = 'Adult' THEN 354
          WHEN ${age_group} = 'Senior' THEN 363
        END ;;
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

  dimension: snack_coefficient {
    type: number
    sql: CASE
          WHEN ${snack} = 'No' THEN 1
          ELSE 0.9
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
