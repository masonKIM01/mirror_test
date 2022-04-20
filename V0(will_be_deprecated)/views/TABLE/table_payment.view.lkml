view: table_payment {
  derived_table: {
    sql: select *
      from chai_card_chai_prod_public.payment p
       ;;
  }

  measure: count_all {
    type: count
    drill_fields: [detail*]
  }

  measure: count {
    type: count_distinct
    sql: ${TABLE}.id ;;
  }

  measure: count_user {
    type: count_distinct
    sql: ${TABLE}.user_id ;;
  }

  measure: total_checkout_amount {
    type: sum
    sql: coalesce(${checkout_amount},0) ;;
  }

  measure: total_cashback_amount {
    type: sum
    sql: coalesce(${cashback_amount},0) ;;
  }

  measure: total_billing_amount {
    type: sum
    sql: coalesce(${billing_amount},0) ;;
  }

  measure: total_charging_amount {
    type: sum
    sql: coalesce(${charging_amount},0) ;;
  }

  dimension: months {
    type: string
    sql: to_char(${TABLE}.created_at,'yyyy-mm-01') ;;
  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: idempotency_key {
    type: string
    sql: ${TABLE}.idempotency_key ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: return_url {
    type: string
    sql: ${TABLE}.return_url ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: updated_at {
    type: time
    sql: ${TABLE}.updated_at ;;
  }

  dimension: merchant_id {
    type: string
    sql: ${TABLE}.merchant_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: discount_amount {
    type: number
    sql: ${TABLE}.discount_amount ;;
  }

  dimension: merchant_discount_amount {
    type: number
    sql: ${TABLE}.merchant_discount_amount ;;
  }

  dimension: checkout_amount {
    type: number
    sql: ${TABLE}.checkout_amount ;;
  }

  dimension: billing_amount {
    type: number
    sql: ${TABLE}.billing_amount ;;
  }

  dimension: charging_amount {
    type: number
    sql: ${TABLE}.charging_amount ;;
  }

  dimension: canceled_amount {
    type: number
    sql: ${TABLE}.canceled_amount ;;
  }

  dimension: coupon_id {
    type: string
    sql: ${TABLE}.coupon_id ;;
  }

  dimension: canceled_billing_amount {
    type: number
    sql: ${TABLE}.canceled_billing_amount ;;
  }

  dimension: canceled_discount_amount {
    type: number
    sql: ${TABLE}.canceled_discount_amount ;;
  }

  dimension: cashback_amount {
    type: number
    sql: ${TABLE}.cashback_amount ;;
  }

  dimension: canceled_cashback_amount {
    type: number
    sql: ${TABLE}.canceled_cashback_amount ;;
  }

  dimension: sub_merchant_id {
    type: number
    sql: ${TABLE}.sub_merchant_id ;;
  }

  dimension: point_amount {
    type: number
    sql: ${TABLE}.point_amount ;;
  }

  dimension: cash_amount {
    type: number
    sql: ${TABLE}.cash_amount ;;
  }

  dimension: canceled_point_amount {
    type: number
    sql: ${TABLE}.canceled_point_amount ;;
  }

  dimension: canceled_cash_amount {
    type: number
    sql: ${TABLE}.canceled_cash_amount ;;
  }

  dimension: merchant_cashback_amount {
    type: number
    sql: ${TABLE}.merchant_cashback_amount ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.version ;;
  }

  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
  }

  set: detail {
    fields: [
      id,
      status,
      idempotency_key,
      currency,
      description,
      return_url,
      created_at_time,
      updated_at_time,
      merchant_id,
      user_id,
      type,
      discount_amount,
      merchant_discount_amount,
      checkout_amount,
      billing_amount,
      charging_amount,
      canceled_amount,
      coupon_id,
      canceled_billing_amount,
      canceled_discount_amount,
      cashback_amount,
      canceled_cashback_amount,
      sub_merchant_id,
      point_amount,
      cash_amount,
      canceled_point_amount,
      canceled_cash_amount,
      merchant_cashback_amount,
      version,
      data,
      year,
      month
    ]
  }
}