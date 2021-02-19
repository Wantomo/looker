view: customer_sales {
  derived_table: {
    sql:  SELECT
            customer_id,
            SUM(base_grand_total) AS lifetime_sales,
            MIN(created_at) AS first_order_date,
            ANY_VALUE(first_order_campaign) AS first_order_campaign,
            ANY_VALUE(first_order_medium) AS first_order_medium,
            ANY_VALUE(first_order_source) AS first_order_source,
            ANY_VALUE(first_order_channel) AS first_order_channel,
            ANY_VALUE(first_order_source_medium) AS first_order_source_medium,
            ANY_VALUE(first_order_source_medium_channel) AS first_order_source_medium_channel,
            ANY_VALUE(first_order_latitude) AS first_order_latitude,
            ANY_VALUE(first_order_longitude) AS first_order_longitude,
            ANY_VALUE(first_order_real_id) AS first_order_real_id
          FROM
            (
              SELECT
                *,
                FIRST_VALUE(source) OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS first_order_source,
                FIRST_VALUE(medium) OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS first_order_medium,
                FIRST_VALUE(campaign) OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS first_order_campaign,
                FIRST_VALUE(channelgrouping) OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS first_order_channel,
                FIRST_VALUE(source_medium) OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS first_order_source_medium,
                FIRST_VALUE(source_medium_channelgrouping) OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS first_order_source_medium_channel,
                FIRST_VALUE(latitude) OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS first_order_latitude,
                FIRST_VALUE(longitude) OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS first_order_longitude,
                FIRST_VALUE(increment_id) OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS first_order_real_id,
              FROM
                ${sales.SQL_TABLE_NAME}
              LEFT JOIN ${sales_utm.SQL_TABLE_NAME} ON ${sales.SQL_TABLE_NAME}.increment_id = ${sales_utm.SQL_TABLE_NAME}.transactionid
            )
          WHERE status IN ('processing', 'pending', 'complete', 'shipped')
          GROUP BY 1
     ;;
  }

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: first_order_date {
    label: "Date of First Order"
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
    sql: ${TABLE}.first_order_date ;;
  }

  dimension: first_order_source {
    type: string
    sql: ${TABLE}.first_order_source ;;
  }

  dimension: first_order_medium {
    type: string
    sql: ${TABLE}.first_order_medium ;;
  }

  dimension: first_order_campaign {
    type: string
    sql: ${TABLE}.first_order_campaign ;;
  }

  dimension: first_order_channel {
    type: string
    sql: ${TABLE}.first_order_channel;;
  }

  dimension: first_order_source_medium {
    type: string
    sql: ${TABLE}.first_order_source_medium ;;
  }

  dimension: first_order_source_medium_channel {
    type: string
    sql: ${TABLE}.first_order_source_medium_channel ;;
  }

  dimension: first_order_latitude {
    type: string
    sql: ${TABLE}.first_order_latitude ;;
  }

  dimension: first_order_longitude {
    type: string
    sql: ${TABLE}.first_order_longitude ;;
  }

  dimension: lifetime_sales {
    type: number
    sql: ${TABLE}.lifetime_sales ;;
  }

  measure: total_lifetime_sales {
    type: sum
    sql: ${lifetime_sales} ;;
  }

  measure: avg_lifetime_sales {
    type: average
    sql: ${lifetime_sales} ;;
    value_format: "0"
  }
}
