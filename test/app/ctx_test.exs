defmodule App.CtxTest do
  use App.DataCase

  alias App.Ctx

  describe "sent" do
    alias App.Ctx.Sent

    @valid_attrs %{message_id: "some message_id", request_id: "some request_id", template: "some template"}
    @update_attrs %{message_id: "some updated message_id", request_id: "some updated request_id", template: "some updated template"}
    @invalid_attrs %{message_id: nil, request_id: nil, template: nil}

    def sent_fixture(attrs \\ %{}) do
      {:ok, sent} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ctx.create_sent()

      sent
    end

    test "list_sent/0 returns all sent" do
      sent = sent_fixture()
      assert Ctx.list_sent() == [sent]
    end

    test "get_sent!/1 returns the sent with given id" do
      sent = sent_fixture()
      assert Ctx.get_sent!(sent.id) == sent
    end

    test "create_sent/1 with valid data creates a sent" do
      assert {:ok, %Sent{} = sent} = Ctx.create_sent(@valid_attrs)
      assert sent.message_id == "some message_id"
      assert sent.request_id == "some request_id"
      assert sent.template == "some template"
    end

    test "create_sent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ctx.create_sent(@invalid_attrs)
    end

    test "update_sent/2 with valid data updates the sent" do
      sent = sent_fixture()
      assert {:ok, %Sent{} = sent} = Ctx.update_sent(sent, @update_attrs)
      assert sent.message_id == "some updated message_id"
      assert sent.request_id == "some updated request_id"
      assert sent.template == "some updated template"
    end

    test "update_sent/2 with invalid data returns error changeset" do
      sent = sent_fixture()
      assert {:error, %Ecto.Changeset{}} = Ctx.update_sent(sent, @invalid_attrs)
      assert sent == Ctx.get_sent!(sent.id)
    end

    test "delete_sent/1 deletes the sent" do
      sent = sent_fixture()
      assert {:ok, %Sent{}} = Ctx.delete_sent(sent)
      assert_raise Ecto.NoResultsError, fn -> Ctx.get_sent!(sent.id) end
    end

    test "change_sent/1 returns a sent changeset" do
      sent = sent_fixture()
      assert %Ecto.Changeset{} = Ctx.change_sent(sent)
    end
  end
end
