view: sales_food_facts {
  sql_table_name: `leafy-habitat-174801.dataform_bi.sales_food_facts`
    ;;

  dimension: entity_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.entity_id ;;
  }

  dimension: gram_per_pet {
    type: number
    sql: ${TABLE}.gram_per_pet ;;
  }

  dimension: gram_per_pet_tier {
    type: tier
    tiers: [150,800,1600,2400,3200]
    style: integer
    sql: ${gram_per_pet} ;;
  }

  dimension: gram_total {
    type: number
    sql: ${TABLE}.gram_total ;;
  }

  dimension: gram_total_tier {
    type: tier
    tiers: [150,800,1600,2400,3200]
    style: integer
    sql: ${gram_total} ;;
  }

  dimension: meat {
    type: string
    sql: ${TABLE}.meat ;;
  }

  dimension: pet_count {
    type: number
    sql: ${TABLE}.pet_count ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
