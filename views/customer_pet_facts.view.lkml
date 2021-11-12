# The name of this view in Looker is "Customer Pet Facts"
view: customer_pet_facts {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `leafy-habitat-174801.dataform_bi.customer_pet_facts`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Count Pet" in Explore.

  dimension: count_pet {
    type: number
    sql: ${TABLE}.count_pet ;;
  }

  dimension: count_pet_tier {
    type: tier
    tiers: [0,1,2,3,4,5,10]
    style: integer
    sql: ${count_pet} ;;
  }

  dimension: count_pet_with_order {
    type: number
    sql: ${TABLE}.count_pet_with_order ;;
  }

  dimension: count_pet_with_order_tier {
    type: tier
    tiers: [0,1,2,3,4,5,10]
    style: integer
    sql: ${count_pet_with_order} ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    primary_key: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_count_pet {
    type: sum
    sql: ${count_pet} ;;
  }

  measure: average_count_pet {
    type: average
    sql: ${count_pet} ;;
  }

  measure: total_count_pet_with_order {
    type: sum
    sql: ${count_pet_with_order} ;;
  }

  measure: average_count_pet_with_order {
    type: average
    sql: ${count_pet_with_order} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
