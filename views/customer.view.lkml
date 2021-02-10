view: customer {
  sql_table_name: `leafy-habitat-174801.looker.customer`
    ;;
  drill_fields: [customer_id]

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: postcode {
    type: string
    sql: ${TABLE}.postcode ;;
  }

  dimension: prefecture {
    type: string
    sql: ${TABLE}.prefecture ;;
  }

  dimension: street {
    type: string
    sql: ${TABLE}.street ;;
  }

  dimension: telephone {
    type: string
    sql: ${TABLE}.telephone ;;
  }

  dimension: first_order_campaign {
    type: string
    sql: (SELECT campaign FROM ${sales.SQL_TABLE_NAME} o LEFT JOIN ${sales_utm.SQL_TABLE_NAME} u ON o.real_order_id = u.id WHERE order_sequence = 1 AND o.customer_id=customer.customer_id ) ;;
  }

  dimension: first_order_source {
    type: string
    sql: (SELECT source FROM ${sales.SQL_TABLE_NAME} o LEFT JOIN ${sales_utm.SQL_TABLE_NAME} u ON o.real_order_id = u.id WHERE order_sequence = 1 AND o.customer_id=customer.customer_id ) ;;
  }

  dimension: first_order_medium {
    type: string
    sql: (SELECT medium FROM ${sales.SQL_TABLE_NAME} o LEFT JOIN ${sales_utm.SQL_TABLE_NAME} u ON o.real_order_id = u.id WHERE order_sequence = 1 AND o.customer_id=customer.customer_id ) ;;
  }

  dimension_group: first_order_date {
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
    sql: (SELECT ${created_date} FROM sales_sequence o WHERE order_sequence = 1 AND o.customer_id=customer.customer_id ) ;;
  }

  dimension: lifetime_sales {
    type: number
    sql: (SELECT SUM(base_grand_total) FROM ${sales.SQL_TABLE_NAME} o WHERE o.customer_id=customer.customer_id AND o.status IN ('processing', 'pending', 'complete', 'shipped')) ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_id, firstname, lastname]
  }

  measure: total_lifetime_sales {
    type: sum
    sql: ${lifetime_sales} ;;
  }
}
