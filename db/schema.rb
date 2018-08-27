# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_25_081922) do

  create_table "answer_checkbox_options", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "check"
    t.bigint "answer_id"
    t.bigint "checkbox_option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_checkbox_options_on_answer_id"
    t.index ["checkbox_option_id"], name: "index_answer_checkbox_options_on_checkbox_option_id"
  end

  create_table "answer_radiobutton_options", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "check"
    t.bigint "answer_id"
    t.bigint "radiobutton_option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_radiobutton_options_on_answer_id"
    t.index ["radiobutton_option_id"], name: "index_answer_radiobutton_options_on_radiobutton_option_id"
  end

  create_table "answer_textareas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.bigint "answer_id"
    t.bigint "textarea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_textareas_on_answer_id"
    t.index ["textarea_id"], name: "index_answer_textareas_on_textarea_id"
  end

  create_table "answer_textboxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.bigint "answer_id"
    t.bigint "textbox_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_textboxes_on_answer_id"
    t.index ["textbox_id"], name: "index_answer_textboxes_on_textbox_id"
  end

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "checkbox_options", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "optionname"
    t.bigint "checkbox_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checkbox_id"], name: "index_checkbox_options_on_checkbox_id"
  end

  create_table "checkboxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subject"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_checkboxes_on_question_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "radiobutton_options", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "optionname"
    t.bigint "radiobutton_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["radiobutton_id"], name: "index_radiobutton_options_on_radiobutton_id"
  end

  create_table "radiobuttons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subject"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_radiobuttons_on_question_id"
  end

  create_table "surveys", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_surveys_on_company_id"
  end

  create_table "textareas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subject"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_textareas_on_question_id"
  end

  create_table "textboxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subject"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_textboxes_on_question_id"
  end

  create_table "user_surveys", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_user_surveys_on_survey_id"
    t.index ["user_id"], name: "index_user_surveys_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.binary "picture"
    t.boolean "president", default: false, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answer_checkbox_options", "answers"
  add_foreign_key "answer_checkbox_options", "checkbox_options"
  add_foreign_key "answer_radiobutton_options", "answers"
  add_foreign_key "answer_radiobutton_options", "radiobutton_options"
  add_foreign_key "answer_textareas", "answers"
  add_foreign_key "answer_textareas", "textareas"
  add_foreign_key "answer_textboxes", "answers"
  add_foreign_key "answer_textboxes", "textboxes"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "checkbox_options", "checkboxes"
  add_foreign_key "checkboxes", "questions"
  add_foreign_key "questions", "surveys"
  add_foreign_key "radiobutton_options", "radiobuttons"
  add_foreign_key "radiobuttons", "questions"
  add_foreign_key "surveys", "companies"
  add_foreign_key "textareas", "questions"
  add_foreign_key "textboxes", "questions"
  add_foreign_key "user_surveys", "surveys"
  add_foreign_key "user_surveys", "users"
  add_foreign_key "users", "companies"
end
