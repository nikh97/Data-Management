# tabletools.py

class LabeledList:

	def __init__(self, data=None, index=None):

		self.values = data

		if index == None:

			self.index = [x for x in range(len(data))]

		else:

			self.index = index


	def __str__(self):

		length = len(self.index)

		string = ''

		converted_index = [str(x) for x in self.index]

		vals_max_len = len(max(converted_index, key=len))

		format_spec = f'>{vals_max_len}'

		string = [f'{self.index[x]:{format_spec}}' + ' ' + str(self.values[x]) for x in range(length)]

		return '\n'.join(string)

	def __repr__(self):

		return self.__str__()

	def __getitem__(self, key_list):

		if isinstance(key_list, LabeledList):

			return self.__getitem__(key_list.values)

		index = []

		data = []

		if isinstance(key_list, list):

			if all(isinstance(x, bool) for x in key_list):

				index = [self.index[i] for i in range(len(key_list)) if key_list[i]]
				data = [self.values[i] for i in range(len(key_list)) if key_list[i]]

			else:

				for i in range(len(self.index)):

					if self.index[i] in key_list:

						index.append(self.index[i])
						data.append(self.values[i])


		else:

			for i in range(len(self.index)):

				if self.index[i] in key_list:

					index.append(self.index[i])
					data.append(self.values[i])


		if len(data) == 1:
			return data[0]

		return LabeledList(data, index)
		

	def __setitem__(self, key, value):

		for i in range(len(self.index)):

			if self.index[i] == key:

				self.values[i] = value

	def __iter__(self):

		return Counter(self.values)

	def __eq__(self, scalar):

		bool_data = [scalar == x for x in self.values]

		return LabeledList(bool_data, self.index)

	def __ne__(self, scalar):

		bool_data = [scalar != x for x in self.values]

		return LabeledList(bool_data, self.index)

	def __gt__(self, scalar):

		bool_data = [x > scalar for x in self.values]

		return LabeledList(bool_data, self.index)

	def __lt__(self, scalar):

		bool_data = [x < scalar for x in self.values]

		return LabeledList(bool_data, self.index)

	def map(self, f):

		new_data = [f(x) for x in self.values]

		return LabeledList(new_data, self.index)

class Counter:

	def __init__(self, n):

		self.values = n
		self.start = 0
		self.length = len(self.values)

	def __iter__(self):

		return self

	def __next__(self):

		if self.start < self.length:

			value = self.values[self.start]

			self.start += 1

			return value

		else:

			raise StopIteration()


class Table:

	def __init__(self, data, index=None, columns=None):

		self.values = data

		if index == None or columns == None:

			if index == None:

				index = [x for x in range(len(data))]

			if columns == None:

				columns = [x for x in range(len(data[0]))]

		

		self.index = index
		self.columns  = columns

	def __str__(self):

		strings = []

		lengths = len(max([str(x) for x in self.columns]))

		converted_index = [str(x) for x in self.index]
		converted_index2 = [str(x) for x in self.columns]

		index_len = len(max(converted_index, key=len))

		index_spec = f'>{index_len}'

		for i in self.values:

			for j in range(len(i)):

				if len(str(i[j])) > lengths:

					lengths = len(str(i[j]))

		data_spec = f'>{lengths}'

		for u in range(len(self.values)):

			strg = f'{str(self.index[u]):{index_spec}}'

			for v in range(len(self.values[u])):

				strg += ' ' + f'{str(self.values[u][v]):{data_spec}}'

			strings.append(strg)

		headers_len = index_len + lengths + 1
		headers_spec = f'>{headers_len}'

		headers = f'{str(self.columns[0]):{headers_spec}}'

		for i in range(1, len(self.columns)):

			headers += f'{str(self.columns[i]):>{lengths + 1}}'

		strings = [headers] + strings

		return '\n'.join(strings)

	def __repr__(self):

		return self.__str__()

	def __getitem__(self, col_list):

		if isinstance(col_list, LabeledList):

			col_list = col_list.values

		if isinstance(col_list, list):

			if all(isinstance(x, bool) for x in col_list):

				incl_data = []
				rows = []

				for i in range(len(self.index)):

					if col_list[i]:

						rows.append(self.index[i])
						incl_data.append(self.values[i])

				return Table(incl_data, rows, self.columns)

			incl_data = [[] for x in self.index]

			headers = []

			for j in range(len(self.columns)):

				for n in col_list:

					if self.columns[j] == n:

						for i in range(len(self.values)):

							incl_data[i].append(self.values[i][j])

						headers.append(n)

			return Table(incl_data, self.index, headers)

		else:

			incl_data = [[] for x in self.index]

			headers = []

			for j in range(len(self.columns)):

					if self.columns[j] == col_list:

						for i in range(len(self.values)):

							incl_data[i].append(self.values[i][j])

						headers.append(col_list)

			if len(headers) == 1:

				return LabeledList([x[0] for x in incl_data], self.index)

			else:
				return Table(incl_data, self.index, headers)

	def __eq__(self, other):

		return (self.values == other.values and self.index == other.index and self.columns == other.columns)

	def __ne__(self, other):

		return (self.values != other.values and self.index != other.index and self.columns != other.columns)

	def head(self, n):

		if n > len(self.index):

			n = len(self.index)

		index = self.index[0:n]

		incl_data = self.values[0:n]

		return Table(incl_data, index, self.columns)

	def tail(self, n):

		if n > len(self.index):

			n = len(self.index)

		index = self.index[(len(self.index) - n)::]

		incl_data = self.values[(len(self.index) - n)::]

		return Table(incl_data, index, self.columns)

	def shape(self):

		return (len(self.index), len(self.columns))

	def read_csv(fn):

		def read_data(fn):

			col = []
			data = []

			with open(fn, 'r') as f:

				string = f.read()

				lines = (string.strip()).split('\n')

				first_line = lines[0]

				for i in first_line.split(','):

					i = i.strip()

					try:

						col.append(float(i))

					except ValueError:

						col.append(i)
						continue


				for line in range(1, len(lines)):

					row = []

					for i in lines[line].split(','):

						i = i.strip()

						try:

							row.append(float(i))

						except ValueError:

							row.append(i)
							continue

					data.append(row)

			return Table(data, columns=col)

		try:

			return read_data(fn)

		except IOError:

			print('An IOError has occurred.')

		except:

			print('An unexpected error has occurred.')



