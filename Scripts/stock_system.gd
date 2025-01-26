extends Node

@onready var purchased_stocks = {}
@onready var purchased_stocks_ids = []

var stock_dict = {
	"ALLCH": Stock.new("Allied Chemical", "ALLCH", 5000 / 160, 160),
	"AMCAN": Stock.new("American Can Company", "AMCAN", 5000 / 115, 115),
	"AMINT": Stock.new("American International Corp", "AMINT", 5000 / 45, 45),
	"AMSRF": Stock.new("American Smelting & Refining", "AMSRF", 5000 / 96, 96),
	"AMSUG": Stock.new("American Sugar Refining", "AMSUG", 5000 / 87, 87),
	"ATT": Stock.new("American Telephone & Telegraph", "ATT", 5000 / 175, 175),
	"AMTOB": Stock.new("American Tobacco Company", "AMTOB", 5000 / 150, 150),
	"ANACO": Stock.new("Anaconda Copper Mining", "ANACO", 5000 / 58, 58),
	"BALDW": Stock.new("Baldwin Locomotive Works", "BALDW", 5000 / 120, 120),
	"BETHS": Stock.new("Bethlehem Steel Corporation", "BETHS", 5000 / 65, 65),
	"BORDN": Stock.new("Borden Company", "BORDN", 5000 / 82, 82),
	"BRIGG": Stock.new("Briggs Manufacturing Company", "BRIGG", 5000 / 74, 74),
	"CHRYL": Stock.new("Chrysler Corporation", "CHRYL", 5000 / 150, 150),
	"COLUM": Stock.new("Columbia Gas and Electric", "COLUM", 5000 / 50, 50),
	"CEDIS": Stock.new("Consolidated Edison", "CEDIS", 5000 / 115, 115),
	"CORNP": Stock.new("Corn Products Refining", "CORNP", 5000 / 62, 62),
	"CURTW": Stock.new("Curtiss-Wright Corporation", "CURTW", 5000 / 35, 35),
	"DUPON": Stock.new("DuPont de Nemours", "DUPON", 5000 / 270, 270),
	"EKMKD": Stock.new("Eastman Kodak Company", "EKMKD", 5000 / 100, 100),
	"ELBNS": Stock.new("Electric Bond and Share Co.", "ELBNS", 5000 / 48, 48),
	"GENEL": Stock.new("General Electric", "GENEL", 5000 / 200, 200),
	"GENFD": Stock.new("General Foods Corporation", "GENFD", 5000 / 64, 64),
	"GENMT": Stock.new("General Motors", "GENMT", 5000 / 175, 175),
	"GDYTR": Stock.new("Goodyear Tire & Rubber", "GDYTR", 5000 / 38, 38),
	"GULFO": Stock.new("Gulf Oil Corporation", "GULFO", 5000 / 75, 75),
	"IBM": Stock.new("International Business Machines", "IBM", 5000 / 125, 125),
	"INHAR": Stock.new("International Harvester", "INHAR", 5000 / 98, 98),
	"JOHNM": Stock.new("Johns-Manville Corporation", "JOHNM", 5000 / 60, 60),
	"KENCO": Stock.new("Kennecott Copper Corporation", "KENCO", 5000 / 58, 58),
	"LIGMY": Stock.new("Liggett & Myers Tobacco", "LIGMY", 5000 / 72, 72),
	"LOEWS": Stock.new("Loews Corporation", "LOEWS", 5000 / 45, 45),
	"MAYDS": Stock.new("May Department Stores", "MAYDS", 5000 / 57, 57),
	"MWRD": Stock.new("Montgomery Ward", "MWRD", 5000 / 96, 96),
	"NABIS": Stock.new("National Biscuit Company", "NABIS", 5000 / 90, 90),
	"NDPDC": Stock.new("National Dairy Products Corp", "NDPDC", 5000 / 41, 41),
	"OTISE": Stock.new("Otis Elevator Company", "OTISE", 5000 / 43, 43),
	"PARAM": Stock.new("Paramount Publix Corp", "PARAM", 5000 / 88, 88),
	"PENRR": Stock.new("Pennsylvania Railroad", "PENRR", 5000 / 55, 55),
	"RCA": Stock.new("Radio Corporation of America", "RCA", 5000 / 110, 110),
	"REPST": Stock.new("Republic Steel", "REPST", 5000 / 46, 46),
	"SEARS": Stock.new("Sears, Roebuck & Co.", "SEARS", 5000 / 103, 103),
	"SINOI": Stock.new("Sinclair Oil Corporation", "SINOI", 5000 / 37, 37),
	"SOCON": Stock.new("Socony-Vacuum Oil Co.", "SOCON", 5000 / 34, 34),
	"SOJER": Stock.new("Standard Oil of New Jersey", "SOJER", 5000 / 75, 75),
	"SOCAL": Stock.new("Standard Oil of California", "SOCAL", 5000 / 85, 85),
	"STUDY": Stock.new("Studebaker Corporation", "STUDY", 5000 / 53, 53),
	"TEXCO": Stock.new("Texas Company", "TEXCO", 5000 / 48, 48),
	"UNCAR": Stock.new("Union Carbide and Carbon Corp", "UNCAR", 5000 / 54, 54),
	"USSCL": Stock.new("United States Steel Corporation", "USSCL", 5000 / 140, 140),
	"WSTEL": Stock.new("Westinghouse Electric Corp", "WSTEL", 5000 / 215, 215)
}

class Stock:
	var name: String = ""
	var id: String = ""
	var share_count: int = 100
	var share_cost: int = 5
	var projection: float = 0 #This means stable
	var original_share_cost: int = 0
	
	func _init(name: String, id: String, share_count: int, share_cost: int):
		self.name = name
		self.id = id
		self.share_count = share_count
		self.share_cost = share_cost
		self.original_share_cost = share_cost
		self.projection = randf() * 2.0 - 1.0
	
	func purchase_stock(amount) -> bool:
		if Globals.money < share_cost * amount:
			return false
		if StockSystem.purchased_stocks.has(id):
			if StockSystem.purchased_stocks[id] + amount > share_count:
				return false 
		else:
			StockSystem.purchased_stocks.get_or_add(id)
			StockSystem.purchased_stocks[id] = 0
			StockSystem.purchased_stocks_ids.append(id)
		StockSystem.purchased_stocks[id] += amount
		Globals.money -= share_cost * amount
		return true
	
	func advance_projection() -> void:
		share_cost += projection
		if share_cost > original_share_cost * 2:
			share_cost = original_share_cost / 2
			share_count *= 2
		elif share_cost < original_share_cost / 2:
			share_cost = original_share_cost * 2
			if StockSystem.purchased_stocks.has(id):
				StockSystem.purchased_stocks[id] /= 2

func is_stock_purchased(id: String) -> bool:
	return purchased_stocks.has(id)
	
func get_player_share_count(id: String) -> int:
	if (!is_stock_purchased(id) || !stock_dict.has(id)):
		return 0
	return purchased_stocks.get(id)

func get_3x3_stock() -> Array:
	var result = []
	while result.size() != 9:
		var new_stock = get_new_stock()
		if result.has(new_stock):
			continue
		result.append(new_stock)
	return result

func get_new_stock() -> Stock:
	var keys = stock_dict.keys()
	return stock_dict[keys[randi() % keys.size()]]
	
func get_inverse_curve(input: int) -> int:
	if input <= 0:
		return int(100000) # 100,000 is the scale
	return int(ceil(100000 / input))
