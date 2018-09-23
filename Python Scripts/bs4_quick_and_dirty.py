import requests
import bs4

url = 'https://adamwathan.me/advanced-vue-component-design/'

r = requests.get(url) #returns the HTML of the page, can be done through urlopen as well

soup = bs4.BeautifulSoup(r.content)

#print soup.prettify()

data = soup.find_all("p",{"class":"text-base text-black leading-tight font-semibold"})

for index, item in enumerate(data):
    print(f"{index+1}|{item.contents[0]}")
