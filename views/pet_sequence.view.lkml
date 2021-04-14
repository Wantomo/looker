view: pet_sequence {
  #Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
      pet_id,
      owner_id,
      created_at,
      completed_at,
      (
        SELECT
          COUNT(*)
        FROM
          pet AS counter
        WHERE
          status = 1
          AND counter.pet_id <= pet.pet_id
          AND counter.owner_id = pet.owner_id) AS pet_sequence
        FROM pet
     ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    convert_tz: no
  }

  dimension_group: completed {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.completed_at ;;
    convert_tz: no
  }

  dimension: owner_id {
    description: "Unique ID for each user"
    type: number
    sql: ${TABLE}.owner_id ;;
  }

  dimension: pet_id {
    description: "Unique ID for each pet"
    type: number
    primary_key: yes
    sql: ${TABLE}.pet_id ;;
  }

  dimension: pet_sequence {
    description: "Sequence of pet per customer"
    type: number
    sql: ${TABLE}.pet_sequence ;;
  }

  measure: count_first_pets {
    label: "Count of first pets"
    type: count
    filters: [pet_sequence: "1"]
  }
}
