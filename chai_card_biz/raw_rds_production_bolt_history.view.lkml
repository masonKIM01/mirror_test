view: raw_rds_production_bolt_history {
  derived_table: {
    sql: select *, abs(count) as bolt
      from raw_rds_production.bolt_history bh
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_bolt {
    type: sum
    sql: ${TABLE}.count ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: count_ {
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension: bolt {
    type: number
    sql: ${TABLE}.bolt ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: sub_title {
    type: string
    sql: ${TABLE}.sub_title ;;
  }

  dimension: available_bolt {
    type: number
    sql: ${TABLE}.available_bolt ;;
  }

  dimension: from_id {
    type: string
    sql: ${TABLE}.from_id ;;
  }

  set: detail {
    fields: [
      created_at_time,
      type,
      count_,
      user_id,
      id,
      bolt,
      action,
      sub_title,
      available_bolt,
      from_id
    ]
  }
}
