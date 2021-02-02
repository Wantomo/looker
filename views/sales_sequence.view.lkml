view: sales_sequence {
  #Or, you could make this view a derived table, like this:
    derived_table: {
    sql: SELECT
      entity_id AS order_id,
      customer_id,
      created_at,
      base_grand_total,
      (
        SELECT
          COUNT(*)
        FROM
          sales AS counter
        WHERE
          status IN ('processing', 'pending', 'complete', 'shipped')
          AND counter.entity_id <= sales.entity_id
          AND counter.customer_id = sales.customer_id) AS order_sequence
        FROM sales
        WHERE status IN ('processing', 'pending', 'complete', 'shipped')
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
  }

  dimension: customer_id {
    description: "Unique ID for each user"
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: order_id {
    description: "Unique ID for each order"
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_sequence {
    description: "Sequence of order per customer"
    type: number
    sql: ${TABLE}.order_sequence ;;
  }

  dimension: base_grand_total {
    type: number
    sql: ${TABLE}.base_grand_total ;;
  }

  measure: count_first_orders {
    label: "Count of first orders"
    type: count
    sql: ${order_sequence} ;;
    filters: [order_sequence: "1"]
  }

  measure: sum_first_orders {
    label: "Sum of first orders"
    type: sum
    sql: ${base_grand_total} ;;
    filters: [order_sequence: "1"]
  }

  measure: count_repeat_orders {
    label: "Count of repeat orders"
    type: count
    sql: ${order_sequence} ;;
    filters: [order_sequence: ">1"]
  }

  measure: sum_repeat_orders {
    label: "Sum of repeat orders"
    type: sum
    sql: ${base_grand_total} ;;
    filters: [order_sequence: ">1"]
  }
}
