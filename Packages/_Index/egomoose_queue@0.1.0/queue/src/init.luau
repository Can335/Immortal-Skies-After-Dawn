--!strict

--[=[
	@class Queue

	A simple class for handling queue data structures.
]=]
local QueueClass = {}
QueueClass.__index = QueueClass
QueueClass.ClassName = "Queue"

export type Queue<T> = typeof(setmetatable(
	{} :: {
		list: { T },
		index: number,
		length: number,
	},
	QueueClass
))

-- Constructors

--[=[
	@within Queue
	@tag Constructor

	Converts the provided list into a queue.

	@param list { T }
	@return Queue
]=]
function QueueClass.new<T>(list: { T }): Queue<T>
	local self = setmetatable({}, QueueClass) :: Queue<T>

	self.index = 1
	self.list = table.clone(list)
	self.length = #self.list

	return self
end

-- Private Methods

local function get<T>(self: Queue<T>, index: number): T?
	return self.list[self.index + index - 1]
end

-- Public Methods

--[=[
	@within Queue
	@tag Method

	Makes a copy of the queue.

	@return Queue
]=]
function QueueClass.clone<T>(self: Queue<T>)
	local elements = self:getElements()
	return QueueClass.new(elements)
end

--[=[
	@within Queue
	@tag Method

	Creates a new queue that has its elements in reverse.

	@return Queue
]=]
function QueueClass.reverse<T>(self: Queue<T>)
	local elements = self:getElements()

	local length = #elements
	local half = math.floor(length / 2)

	for i = 1, half do
		local j = length - i + 1
		elements[i], elements[j] = elements[j], elements[i]
	end

	return QueueClass.new(elements)
end

--[=[
	@within Queue
	@tag Method

	Returns all the elements in the queue as an array.
	
	@return { T }
]=]
function QueueClass.getElements<T>(self: Queue<T>): { T }
	local elements = table.create(self.length, nil)
	table.move(self.list, self.index, self.index + self.length, 1, elements)
	return elements
end

--[=[
	@within Queue
	@tag Method

	Returns the number of elements in the queue.
	
	@return number
]=]
function QueueClass.getLength<T>(self: Queue<T>)
	return self.length
end

--[=[
	@within Queue
	@tag Method

	Returns the element at the index provided in the queue.

	The provided index cannot fall out of the following bounds `[1, queue:getLength()]` or an error will occur.

	@param index number
	@return T
]=]
function QueueClass.get<T>(self: Queue<T>, index: number)
	assert(index > 0 and index <= self.length, "Index out of range.")
	return get(self, index) :: T
end

--[=[
	@within Queue
	@tag Method

	Returns the element at front of the queue.
	
	@return T?
]=]
function QueueClass.getFront<T>(self: Queue<T>)
	return get(self, 1)
end

--[=[
	@within Queue
	@tag Method

	Returns the element at back of the queue.
	
	@return T?
]=]
function QueueClass.getBack<T>(self: Queue<T>)
	return get(self, self.length)
end

--[=[
	@within Queue
	@tag Method

	Inserts a new the element in the provided index of the queue while shifting all following elements.

	The provided index cannot fall out of the following bounds `[1, queue:getLength() + 1]` or an error will occur.
	
	@param index number
	@param value T
]=]
function QueueClass.insert<T>(self: Queue<T>, index: number, value: T)
	assert(index > 0 and index <= self.length + 1, "Index out of range.")

	for i = self.length, index, -1 do
		local j = self.index + (i - 1)
		self.list[j + 1] = self.list[j]
	end

	self.list[self.index + (index - 1)] = value
	self.length = self.length + 1
end

--[=[
	@within Queue
	@tag Method

	Removes the element at the provided index of the queue while shifting all following elements.

	The provided index cannot fall out of the following bounds `[1, queue:getLength()]` or an error will occur.
	
	@param index number
	@return T
]=]
function QueueClass.remove<T>(self: Queue<T>, index: number)
	assert(index > 0 and index <= self.length, "Index out of range.")

	local popped = self.list[self.index + (index - 1)]

	for i = index + 1, self.length do
		local j = self.index + (i - 1)
		self.list[j - 1] = self.list[j]
	end

	self.list[self.index + self.length - 1] = nil
	self.length = self.length - 1

	return popped
end

--[=[
	@within Queue
	@tag Method

	Removes the element at the end of the queue and returns it.

	The provided index cannot fall out of the following bounds `[1, queue:getLength()]` or an error will occur.
	
	@return T
]=]
function QueueClass.popBack<T>(self: Queue<T>)
	return self:remove(self.length)
end

--[=[
	@within Queue
	@tag Method

	Appends the element at the end of the queue.
	
	@param value T
]=]
function QueueClass.pushBack<T>(self: Queue<T>, value: T)
	self:insert(self.length + 1, value)
end

--[=[
	@within Queue
	@tag Method

	Removes the element at the front of the queue and returns it.

	The provided index cannot fall out of the following bounds `[1, queue:getLength()]` or an error will occur.
	
	@return T
]=]
function QueueClass.popFront<T>(self: Queue<T>)
	return self:remove(1)
end

--[=[
	@within Queue
	@tag Method

	Appends the element at the front of the queue.
	
	@param value T
]=]
function QueueClass.pushFront<T>(self: Queue<T>, value: T)
	self:insert(1, value)
end

--[=[
	@within Queue
	@tag Method

	Replaces the element at the index in the queue.

	The provided index cannot fall out of the following bounds `[1, queue:getLength()]` or an error will occur.
	
	@param index number
	@param value T
]=]
function QueueClass.replace<T>(self: Queue<T>, index: number, value: T)
	assert(index > 0 and index <= self.length + 1, "Index out of range.")

	self.list[self.index + (index - 1)] = value
end

--[=[
	@within Queue
	@tag Method

	Swaps two elements already in the queue with each other.

	The provided indices cannot fall out of the following bounds `[1, queue:getLength()]` or an error will occur.
	
	@param i number -- the index of element A
	@param j number -- the index of element B
]=]
function QueueClass.swap<T>(self: Queue<T>, i: number, j: number)
	local iv = self:get(i)
	local jv = self:get(j)

	self:replace(i, jv)
	self:replace(j, iv)
end

--[=[
	@within Queue
	@tag Method

	Removes multiple elements from the queue and returns them.

	The provided combination of from and length cannot fall out of the following bounds `[1, queue:getLength()]` or an error will occur.
	
	@param from number -- the starting index of the removal
	@param length number -- how many elements to remove
]=]
function QueueClass.drain<T>(self: Queue<T>, from: number, length: number)
	local drained = {}

	for _i = from, from + length - 1 do
		local popped = self:remove(from)
		table.insert(drained, popped)
	end

	return drained
end

--[=[
	@within Queue
	@tag Method

	Searches for the element in the queue and if found returns its index in the queue.
	
	@param value T
	@return number
]=]
function QueueClass.find<T>(self: Queue<T>, value: T): number?
	for i = 1, self.length do
		local j = self.index + (i - 1)
		if self.list[j] == value then
			return j
		end
	end
	return nil
end

--[=[
	@within Queue
	@tag Method

	Removes every element in the queue.
]=]
function QueueClass.clear<T>(self: Queue<T>)
	self.index = 1
	self.list = {}
	self.length = 0
end

--

return QueueClass
