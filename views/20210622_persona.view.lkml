view: survey_20210622_persona {
  sql_table_name: `leafy-habitat-174801.survey.20210622_persona`
    ;;

  dimension: age {
    type: string
    sql: ${TABLE}.age ;;
  }

  dimension: can_contact {
    type: string
    sql: ${TABLE}.can_contact ;;
  }

  dimension: collector_id {
    type: string
    sql: ${TABLE}.collector_id ;;
  }

  dimension: customer_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: date_created {
    type: string
    sql: ${TABLE}.date_created ;;
  }

  dimension: date_modified {
    type: string
    sql: ${TABLE}.date_modified ;;
  }

  dimension: dog_information_source {
    type: string
    sql: ${TABLE}.dog_information_source ;;
  }

  dimension: family_structure {
    type: string
    sql: ${TABLE}.family_structure ;;
  }

  dimension: food_key_purchase_factor {
    type: string
    sql: ${TABLE}.food_key_purchase_factor ;;
  }

  dimension: food_ranking_factor {
    type: string
    sql: ${TABLE}.food_ranking_factor ;;
  }

  dimension: food_recommendation {
    type: string
    sql: ${TABLE}.food_recommendation ;;
  }

  dimension: food_rotation {
    type: string
    sql: ${TABLE}.food_rotation ;;
  }

  dimension: hobby {
    type: string
    sql: ${TABLE}.hobby ;;
  }

  dimension: monthly_spending_dog {
    type: string
    sql: ${TABLE}.monthly_spending_dog ;;
  }

  dimension: profession {
    type: string
    sql: ${TABLE}.profession ;;
  }

  dimension: respondent_id {
    type: string
    sql: ${TABLE}.respondent_id ;;
  }

  dimension: sns_posting {
    type: string
    sql: ${TABLE}.sns_posting ;;
  }

  dimension: which_dog_service {
    type: string
    sql: ${TABLE}.which_dog_service ;;
  }

  dimension: why_buy_dog {
    type: string
    sql: ${TABLE}.why_buy_dog ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
