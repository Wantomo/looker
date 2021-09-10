view: sales_churn {
  derived_table: {
    sql:
        WITH
        churn_dates AS (
          SELECT
            customer_id,
            MAX(entity_id) AS entity_id,
            TIMESTAMP_TRUNC(created_at, MONTH) AS created_at,
            MAX(churn_group) AS churn_group,
            MAX(TIMESTAMP_TRUNC(churn_date_group_1, MONTH)) AS churn_date_group_1,
            MAX(TIMESTAMP_TRUNC(churn_date_group_2, MONTH)) AS churn_date_group_2,
            MAX(TIMESTAMP_TRUNC(churn_date_group_3, MONTH)) AS churn_date_group_3,
            MAX(TIMESTAMP_TRUNC(churn_date_group_4, MONTH)) AS churn_date_group_4,
            MAX(TIMESTAMP_TRUNC(churn_date_group_5, MONTH)) AS churn_date_group_5,
          FROM
            `leafy-habitat-174801.dataform_bi.sales_sequence`
          GROUP BY
            customer_id,
            TIMESTAMP_TRUNC(created_at, MONTH)
        ),
        orders AS (
          SELECT
            churn_dates.created_at,
            COUNT(churn_dates.customer_id) AS count_customers
          FROM
            churn_dates AS churn_dates
          GROUP BY
            churn_dates.created_at
        ),
        churn_date_group_1 AS (
          SELECT
            churn_dates.churn_date_group_1,
            COUNT(churn_dates.customer_id) AS count_customers
          FROM
            churn_dates AS churn_dates
          GROUP BY
            churn_dates.churn_date_group_1
        ),
        churn_date_group_2 AS (
          SELECT
            churn_dates.churn_date_group_2,
            COUNT(churn_dates.customer_id) AS count_customers
          FROM
            churn_dates AS churn_dates
          GROUP BY
            churn_dates.churn_date_group_2
        ),
        churn_date_group_3 AS (
          SELECT
            churn_dates.churn_date_group_3,
            COUNT(churn_dates.customer_id) AS count_customers
          FROM
            churn_dates AS churn_dates
          GROUP BY
            churn_dates.churn_date_group_3
        ),
        churn_date_group_4 AS (
          SELECT
            churn_dates.churn_date_group_4,
            COUNT(churn_dates.customer_id) AS count_customers
          FROM
            churn_dates AS churn_dates
          GROUP BY
            churn_dates.churn_date_group_4
        ),
        churn_date_group_5 AS (
          SELECT
            churn_dates.churn_date_group_5,
            COUNT(churn_dates.customer_id) AS count_customers
          FROM
            churn_dates AS churn_dates
          GROUP BY
            churn_dates.churn_date_group_5
        )
      SELECT
        orders.*,
        churn_date_group_1.count_customers AS count_group_1,
        churn_date_group_2.count_customers AS count_group_2,
        churn_date_group_3.count_customers AS count_group_3,
        churn_date_group_4.count_customers AS count_group_4,
        churn_date_group_5.count_customers AS count_group_5
      FROM
        orders AS orders
      LEFT JOIN
        churn_date_group_1
      ON
        churn_date_group_1.churn_date_group_1 = orders.created_at
      LEFT JOIN
        churn_date_group_2
      ON
        churn_date_group_2.churn_date_group_2 = orders.created_at
      LEFT JOIN
        churn_date_group_3
      ON
        churn_date_group_3.churn_date_group_3 = orders.created_at
      LEFT JOIN
        churn_date_group_4
      ON
        churn_date_group_4.churn_date_group_4 = orders.created_at
      LEFT JOIN
        churn_date_group_5
      ON
        churn_date_group_5.churn_date_group_5 = orders.created_at
      WHERE created_at >= '2017-04-01';;
  }

  dimension_group: created {
    label: "Order"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    convert_tz: no
  }

  dimension: count_customers {
    type: number
    sql: ${TABLE}.count_customers ;;
  }

  dimension: count_group_1 {
    type: number
    sql: ${TABLE}.count_group_1 ;;
  }

  dimension: count_group_2 {
    type: number
    sql: ${TABLE}.count_group_2 ;;
  }

  dimension: count_group_3 {
    type: number
    sql: ${TABLE}.count_group_3 ;;
  }

  dimension: count_group_4 {
    type: number
    sql: ${TABLE}.count_group_4 ;;
  }

  dimension: count_group_5 {
    type: number
    sql: ${TABLE}.count_group_5 ;;
  }

  measure: sum_count_customers {
    label: "Sum Customers"
    type: sum
    sql: ${count_customers} ;;
  }

  measure: sum_count_group_1 {
    label: "Sum Low (+30d)"
    type: sum
    sql: ${count_group_1} ;;
  }

  measure: sum_count_group_2 {
    label: "Sum Medium (+60d)"
    type: sum
    sql: ${count_group_2} ;;
  }

  measure: sum_count_group_3 {
    label: "Sum High (+90d)"
    type: sum
    sql: ${count_group_3} ;;
  }

  measure: sum_count_group_4 {
    label: "Sum Very High (+150d)"
    type: sum
    sql: ${count_group_4} ;;
  }

  measure: sum_count_group_5 {
    label: "Sum Sayonara (+270d)"
    type: sum
    sql: ${count_group_5} ;;
  }

}
