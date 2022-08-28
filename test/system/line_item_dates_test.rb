require 'application_system_test_case'

class LineItemDatesTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)

    @quote = quotes(:first)
    @line_item_date = line_item_dates(:today)

    visit quote_path(@quote)
  end

  test 'Creating a new line item date' do
    assert_selector 'h1', text: '最初の引用文'

    click_on 'New date'
    assert_selector 'h1', text: '最初の引用文'
    fill_in 'Date', with: Date.current + 1.day

    click_on 'Create date'
    assert_text I18n.l(Date.current + 1.day, format: :long)
  end

  test 'Updating line item date' do
    assert_selector 'h1', text: '最初の引用文'

    within id: dom_id(@line_item_date, :edit) do
      click_on 'Edit'
    end

    assert_selector 'h1', text: '最初の引用文'

    fill_in 'Date', with: Date.current + 1.day
    click_on 'Update date'

    assert_text I18n.l(Date.current + 1.day, format: :long)
  end

  test 'Destroying a line item date' do
    assert_text I18n.l(Date.current, format: :long)

    accept_confirm do
      within id: dom_id(@line_item_date, :edit) do
        click_on 'Delete'
      end
    end

    assert_no_text I18n.l(Date.current, format: :long)
  end
end
