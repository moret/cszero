require 'test_helper'

class CaseTest < ActiveSupport::TestCase
  setup do
    Case.collection.drop
  end

  test "type must be either phone, chat, or email and not empty" do
    assert_empty Case.create(type: 'phone').errors[:type]
    assert_empty Case.create(type: 'chat').errors[:type]
    assert_empty Case.create(type: 'email').errors[:type]
    assert_equal 'is not included in the list', Case.create(type: 'smoke').errors[:type][0]
    assert_equal "can't be blank", Case.create(type: '').errors[:type][0]
  end

  test "uf must be a brazil uf and not empty" do
    assert_empty Case.create(uf: 'RJ').errors[:uf]
    assert_empty Case.create(uf: 'DF').errors[:uf]
    assert_equal 'is not included in the list', Case.create(uf: 'MO').errors[:uf][0]
    assert_equal "can't be blank", Case.create(uf: '').errors[:uf][0]
  end

  test "reason must be question, compliment, or suggestion and not empty" do
    assert_empty Case.create(reason: 'question').errors[:reason]
    assert_empty Case.create(reason: 'compliment').errors[:reason]
    assert_empty Case.create(reason: 'suggestion').errors[:reason]
    assert_equal 'is not included in the list', Case.create(reason: 'complaint').errors[:reason][0]
    assert_equal "can't be blank", Case.create(reason: '').errors[:reason][0]
  end

  test "notes not empty" do
    assert_empty Case.create(notes: 'Fancy points.').errors[:notes]
    assert_equal "can't be blank", Case.create(notes: '').errors[:notes][0]
  end

  test "email must be of an user" do
    assert_empty Case.create(email: 'user@cszero.com').errors[:email]
    assert_equal "can't be blank", Case.create(email: '').errors[:email][0]
  end

  test "date added on creation" do
    newCase = Case.new type: 'phone', uf: 'RJ', reason: 'question', notes: 'Fancy Points.', email: 'user@cszero'
    assert_nil newCase.date
    travel_to Date.new(2017, 8, 16) do
      newCase.save
      assert_equal DateTime.now, newCase.date
    end
  end

  test "report groups by day ascending, uf descending, and sorts by date" do
    Case.create! type: 'email', uf: 'RJ', reason: 'suggestion', notes: 'Writes too much.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T10:34:45Z')
    Case.create! type: 'chat', uf: 'RJ', reason: 'compliment', notes: 'Writes too little.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T11:34:45Z')
    Case.create! type: 'chat', uf: 'DF', reason: 'suggestion', notes: 'A bit of cheese.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T12:34:45Z')
    Case.create! type: 'email', uf: 'AC', reason: 'compliment', notes: 'Mythical.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T10:34:45Z')
    Case.create! type: 'phone', uf: 'MG', reason: 'suggestion', notes: 'Ugly voice.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T11:34:45Z')
    Case.create! type: 'chat', uf: 'MG', reason: 'compliment', notes: 'Slow typer.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T15:34:45Z')
    report = Case.report
    assert_equal '2017-08-16', report[0]._id.day
    assert_equal 'AC', report[0]._id.uf
    assert_equal '2017-08-16', report[1]._id.day
    assert_equal 'MG', report[1]._id.uf
    assert_equal DateTime.strptime('2017-08-16T15:34:45Z'), report[1].cases[0].date
    assert_equal DateTime.strptime('2017-08-16T11:34:45Z'), report[1].cases[1].date
    assert_equal '2017-08-15', report[2]._id.day
    assert_equal 'DF', report[2]._id.uf
    assert_equal '2017-08-15', report[3]._id.day
    assert_equal 'RJ', report[3]._id.uf
    assert_equal DateTime.strptime('2017-08-15T11:34:45Z'), report[3].cases[0].date
    assert_equal DateTime.strptime('2017-08-15T10:34:45Z'), report[3].cases[1].date
  end
end
