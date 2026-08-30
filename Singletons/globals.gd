extends Node

enum ChessPiece {
	EMPTY,
	#PAWN,
	#ROOK,
	#BISHOP,
	KNIGHT,
	#QUEEN,
	KING,
};

var movesets: Dictionary = {
	ChessPiece.EMPTY: [],
	#ChessPiece.PAWN: [
			#Vector2i(-1, -1),
			#Vector2i(1, -1),
		#],
	ChessPiece.KNIGHT: [
			Vector2i(-1, -2),
			Vector2i(1, -2),
			Vector2i(2, -1),
			Vector2i(2, 1),
			Vector2i(1, 2),
			Vector2i(-1, 2),
			Vector2i(-2, 1),
			Vector2i(-2, -1),
		],
	ChessPiece.KING: [
			Vector2i(-1, -1),
			Vector2i(0, -1),
			Vector2i(1, -1),
			Vector2i(1, 0),
			Vector2i(1, 1),
			Vector2i(0, 1),
			Vector2i(-1, 1),
			Vector2i(-1, 0),
		],
};

var default_bg_tile_color: Color = Color(0.0, 0.0, 0.0, 1.0);

var colorscheme: Dictionary = {
	ChessPiece.EMPTY: Color(0.851, 0.851, 0.851, 1.0),
	ChessPiece.KNIGHT: Color(0.345, 0.75, 0.075, 1.0),
	ChessPiece.KING: Color(0.88, 0.163, 0.053, 1.0),
};
