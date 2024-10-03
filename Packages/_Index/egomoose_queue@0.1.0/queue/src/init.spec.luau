--!strict

local function generateAlphabet(length: number)
	local alphabet = {}
	for i = 1, math.min(length, 26) do
		table.insert(alphabet, string.char(97 + i - 1))
	end
	return alphabet
end

local ALPHABET = table.freeze(generateAlphabet(26))

return function()
	local QueueClass = require(script.Parent)

	describe(":clone()", function()
		it("should match after construction", function()
			local q = QueueClass.new(ALPHABET)
			local qc = q:clone()

			expect(q:getLength()).to.equal(qc:getLength())

			for i = 1, q:getLength() do
				expect(q:get(i)).to.equal(qc:get(i))
			end
		end)

		it("should match after mutation", function()
			local q = QueueClass.new(ALPHABET)

			q:popFront()
			q:popBack()
			q:popFront()
			q:popBack()

			local qc = q:clone()

			expect(q:getLength()).to.equal(qc:getLength())

			for i = 1, q:getLength() do
				expect(q:get(i)).to.equal(qc:get(i))
			end
		end)
	end)

	describe(":reverse()", function()
		it("should match after construction", function()
			local q = QueueClass.new(ALPHABET)
			local qc = q:reverse()

			local length = q:getLength()
			expect(length).to.equal(qc:getLength())

			for i = 1, length do
				expect(q:get(i)).to.equal(qc:get(length - i + 1))
			end
		end)

		it("should match after mutation", function()
			local q = QueueClass.new(ALPHABET)

			q:popFront()
			q:popBack()
			q:popFront()
			q:popBack()

			local qc = q:reverse()

			local length = q:getLength()
			expect(length).to.equal(qc:getLength())

			for i = 1, length do
				expect(q:get(i)).to.equal(qc:get(length - i + 1))
			end
		end)
	end)

	describe(":getElements()", function()
		it("should match after construction", function()
			local q = QueueClass.new(ALPHABET)
			local elements = q:getElements()

			expect(#elements).to.equal(#ALPHABET)

			for i = 1, #elements do
				expect(elements[i]).to.equal(ALPHABET[i])
			end
		end)

		it("should match after mutation", function()
			local q = QueueClass.new(ALPHABET)

			q:popFront()
			q:popBack()
			q:popFront()
			q:popBack()

			local elements = q:getElements()
			expect(#elements).to.equal(#ALPHABET - 4)

			for i = 1, #elements do
				expect(elements[i]).to.equal(ALPHABET[i + 2])
			end
		end)
	end)

	describe(":getLength()", function()
		it("after construction", function()
			local q = QueueClass.new(ALPHABET)

			expect(q:getLength()).to.equal(#ALPHABET)
		end)

		it("after :popFront()", function()
			local q = QueueClass.new(ALPHABET)

			for i = #ALPHABET, 1, -1 do
				q:popFront()
				expect(q:getLength()).to.equal(i - 1)
			end
		end)

		it("after :pushFront()", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				q:pushFront(ALPHABET[i])
				expect(q:getLength()).to.equal(#ALPHABET + i)
			end
		end)

		it("after :popBack()", function()
			local q = QueueClass.new(ALPHABET)

			for i = #ALPHABET, 1, -1 do
				q:popBack()
				expect(q:getLength()).to.equal(i - 1)
			end
		end)

		it("after :pushBack()", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				q:pushBack(ALPHABET[i])
				expect(q:getLength()).to.equal(#ALPHABET + i)
			end
		end)

		it("after :insert()", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				q:insert(20, ALPHABET[i])
				expect(q:getLength()).to.equal(#ALPHABET + i)
			end
		end)

		it("after :remove()", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				q:remove(1)
				expect(q:getLength()).to.equal(#ALPHABET - i)
			end
		end)

		it("after :drain()", function()
			local q = QueueClass.new(ALPHABET)
			local half = math.floor(#ALPHABET / 2)

			q:drain(1, half)
			expect(q:getLength()).to.equal(#ALPHABET - half)
		end)

		it("after :clear()", function()
			local q = QueueClass.new(ALPHABET)

			q:clear()
			expect(q:getLength()).to.equal(0)
		end)

		it("after :swap()", function()
			local q = QueueClass.new(ALPHABET)
			local half = math.floor(#ALPHABET / 2)

			for i = 1, half do
				q:swap(i, #ALPHABET + 1 - i)
				expect(q:getLength()).to.equal(#ALPHABET)
			end
		end)

		it("after :clone()", function()
			local q = QueueClass.new(ALPHABET):clone()

			expect(q:getLength()).to.equal(#ALPHABET)
		end)

		it("after :reverse()", function()
			local q = QueueClass.new(ALPHABET):reverse()

			expect(q:getLength()).to.equal(#ALPHABET)
		end)
	end)

	describe(":get()", function()
		it("should return the element at the index in the queue", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				expect(q:get(i)).to.equal(ALPHABET[i])
			end
		end)

		it("should error if the index is out of bounds", function()
			local q = QueueClass.new({})

			expect(function()
				q:get(2)
			end).to.throw()
		end)
	end)

	describe(":getFront()", function()
		it("should return the front of the queue", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				expect(q:getFront()).to.equal(ALPHABET[1])
				q:popBack()
			end

			q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				expect(q:getFront()).to.equal(ALPHABET[i])
				q:popFront()
			end
		end)

		it("should return nil if empty", function()
			local q = QueueClass.new({})

			expect(q:getFront()).to.equal(nil)
		end)
	end)

	describe(":getBack()", function()
		it("should return the back of the queue", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				expect(q:getBack()).to.equal(ALPHABET[#ALPHABET - i + 1])
				q:popBack()
			end

			q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				expect(q:getBack()).to.equal(ALPHABET[#ALPHABET])
				q:popFront()
			end
		end)

		it("should return nil if empty", function()
			local q = QueueClass.new({})

			expect(q:getBack()).to.equal(nil)
		end)
	end)

	describe(":insert()", function()
		it("should match construction", function()
			local q = QueueClass.new(ALPHABET)
			local q2 = QueueClass.new({})

			for i = 1, #ALPHABET do
				q2:insert(q2:getLength() + 1, ALPHABET[i])
			end

			for i = 1, #ALPHABET do
				expect(q2:get(i)).to.equal(q:get(i))
			end
		end)

		it("should match :reverse()", function()
			local q = QueueClass.new(ALPHABET):reverse()
			local q2 = QueueClass.new({})

			for i = 1, #ALPHABET do
				print(ALPHABET[i])
				q2:insert(1, ALPHABET[i])
			end

			for i = 1, #ALPHABET do
				expect(q2:get(i)).to.equal(q:get(i))
			end
		end)

		it("should fail if index is out of range", function()
			local q = QueueClass.new({})

			expect(function()
				q:insert(2, ALPHABET[1])
			end).to.throw()
		end)
	end)

	describe(":remove()", function()
		it("should remove from back", function()
			local q = QueueClass.new(ALPHABET)

			for i = #ALPHABET, 1, -1 do
				local popped = q:remove(i)
				expect(popped).to.equal(ALPHABET[i])
			end

			expect(q:getLength()).to.equal(0)
		end)

		it("should remove from front", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				local popped = q:remove(1)
				expect(popped).to.equal(ALPHABET[i])
			end

			expect(q:getLength()).to.equal(0)
		end)

		it("should remove from middle", function()
			local q = QueueClass.new(ALPHABET)
			local half = math.floor(#ALPHABET / 2)

			local mutatedAlphabet = table.clone(ALPHABET)
			local removed = table.remove(mutatedAlphabet, half)

			local popped = q:remove(half)
			expect(popped).to.equal(ALPHABET[half])
			expect(popped).to.equal(removed)
			expect(q:getLength()).to.equal(#mutatedAlphabet)

			for i = 1, #mutatedAlphabet do
				expect(q:get(i)).to.equal(mutatedAlphabet[i])
			end
		end)

		it("should fail if index is out of range", function()
			local q = QueueClass.new({})

			expect(function()
				q:remove(2)
			end).to.throw()
		end)
	end)

	describe(":popBack()", function()
		it("should remove from back", function()
			local q = QueueClass.new(ALPHABET)

			for i = #ALPHABET, 1, -1 do
				local popped = q:popBack()
				expect(popped).to.equal(ALPHABET[i])
			end

			expect(q:getLength()).to.equal(0)
		end)

		it("should fail if empty", function()
			local q = QueueClass.new({})

			expect(function()
				q:popBack()
			end).to.throw()
		end)
	end)

	describe(":pushBack()", function()
		it("should insert at the back", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				q:pushBack(ALPHABET[i])
			end

			for i = 1, #ALPHABET * 2 do
				expect(q:get(i)).to.equal(ALPHABET[(i - 1) % #ALPHABET + 1])
			end

			expect(q:getLength()).to.equal(#ALPHABET * 2)
		end)
	end)

	describe(":popFront()", function()
		it("should remove from front", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				local popped = q:popFront()
				expect(popped).to.equal(ALPHABET[i])
			end

			expect(q:getLength()).to.equal(0)
		end)

		it("should fail if empty", function()
			local q = QueueClass.new({})

			expect(function()
				q:popFront()
			end).to.throw()
		end)
	end)

	describe(":pushFront()", function()
		it("should insert at the front", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				q:pushFront(ALPHABET[i])
			end

			for i = 1, #ALPHABET do
				expect(q:get(i)).to.equal(ALPHABET[#ALPHABET - i + 1])
			end

			for i = 1, #ALPHABET do
				expect(q:get(#ALPHABET + i)).to.equal(ALPHABET[i])
			end

			expect(q:getLength()).to.equal(#ALPHABET * 2)
		end)
	end)

	describe(":replace()", function()
		it("should replace the element in the queue", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				local v = q:get(i)
				q:replace(i, v:upper())
				expect(q:get(i)).to.equal(ALPHABET[i]:upper())
			end
		end)

		it("should fail if index is out of range", function()
			local q = QueueClass.new({})

			expect(function()
				q:replace(2, ALPHABET[1])
			end).to.throw()
		end)
	end)

	describe(":swap()", function()
		it("should match :reverse()", function()
			local q = QueueClass.new(ALPHABET)
			local qr = q:reverse()

			for i = 1, math.floor(#ALPHABET / 2) do
				q:swap(i, #ALPHABET - i + 1)
			end

			for i = 1, #ALPHABET do
				expect(q:get(i)).to.equal(qr:get(i))
			end
		end)

		it("should fail if the inputs are out of range", function()
			local q = QueueClass.new({})

			expect(function()
				q:swap(2, 3)
			end).to.throw()
		end)
	end)

	describe(":drain()", function()
		it("remove a chunk from the queue", function()
			local q = QueueClass.new(ALPHABET)

			local half = math.floor(#ALPHABET / 2)
			q:drain(1, half)

			for i = half + 1, #ALPHABET do
				expect(q:get(i - half)).to.equal(ALPHABET[i])
			end
		end)

		it("return the removed elements", function()
			local q = QueueClass.new(ALPHABET)

			local fourth = math.floor(#ALPHABET / 4)
			local drained = q:drain(fourth, fourth)

			expect(#drained).to.equal(fourth)

			for i = fourth, (fourth * 2) - 1 do
				expect(drained[i - fourth + 1]).to.equal(ALPHABET[i])
			end
		end)

		it("should fail if the inputs are out of range", function()
			local q = QueueClass.new({})

			expect(function()
				q:drain(2, 3)
			end).to.throw()
		end)
	end)

	describe(":find()", function()
		it("should return the index of things in the queue", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				expect(q:find(ALPHABET[i])).to.equal(i)
			end
		end)

		it("should return nil for things not in the queue", function()
			local q = QueueClass.new(ALPHABET)

			for i = 1, #ALPHABET do
				expect(q:find(tostring(i))).to.equal(nil)
			end
		end)
	end)

	describe(":clear()", function()
		it("should empty the queue", function()
			local q = QueueClass.new(ALPHABET)
			q:clear()

			expect(q:getLength()).to.equal(0)
		end)
	end)
end
