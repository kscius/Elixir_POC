defmodule Cards do
  @moduledoc """
    Privides a set of cards for use in a game. Returns a list of cards.
  """
  @doc """
    Creates a new deck of cards.
  """
  def create_deck do
    values = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]
    suits = ["Spades","Clubs","Hearts","Diamonds"]

    cards =
      for suit <- suits, value <- values do
        "#{value} of #{suit}"
      end

    shuffle(cards)
  end

  @doc """
    Try to shuffle the `deck` multiple times to get the ilusion of randomize.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
    |>Enum.shuffle
    |>Enum.shuffle
  end

  @doc """
    Ask if the `deck` contains a card(`hand`).
  """
  def contains?(deck,hand) do
    Enum.member?(deck,hand)
  end

  @doc """
    Draw a set of cards (`hand_size`) from the `deck`. Retuns a tuple of the drawn cards and the remaining cards.
  ## Example
      iex> deck = Cards.create_deck
      iex> {hand, remain_deck }= Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck,hand_size) do
    Enum.split(deck,hand_size)
  end

  @doc """
    Store the `deck` in a file. The `filename` is the name of the file to store the deck in.
  """
  def save(deck,filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename,binary)
  end

  @doc """
    Load a deck from a file. The `filename` is the name of the file to load the deck from.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "Error loading deck"
    end
  end

  @doc """
    Give the player a hand of cards givin the `hand_size`. Returns a tuple of the hand and the remaining cards.
  """
  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end
end
