[Painting, Artist].each{|m| m.destroy_all }

artist_data = [
  {
    name: 'Petrus Christus',
    hometown: 'Baarle-Hertog, Belgium',
    birthday: '1410',
    deathday: '1475'
  },
  {
    name: 'Johannes Vermeer',
    hometown: 'Delft, Netherlands',
    birthday: '1632',
    deathday: '1675'
  },
  {
    name: 'Rembrandt van Rijn',
    hometown: 'Leiden, Netherlands',
    birthday: '1606',
    deathday: '1669'
  },
  {
    name: 'Peter Paul Rubens',
    hometown: 'Siegen, Westphalia',
    birthday: '1577',
    deathday: '1640'
  },
  {
    name: 'Bartholomaeus Spranger',
    hometown: 'Antwerp, Belgium',
    birthday: '1546',
    deathday: '1611'
  },
  {
    name: 'Frans Hals',
    hometown: 'Antwerp, Belgium',
    birthday: '1582',
    deathday: '1666'
  }
]

artists = artist_data.map{|attributes| Artist.create(attributes)}

painting_data =  [
  {
    date: '1446',
    dimensions_text: '11 1/2 Ã— 8 1/2 in',
    height: 11.5,
    width: 8.5,
    slug: 'petrus-christus-portrait-of-a-carthusian',
    title: 'Portrait of a Carthusian',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/pVc7CubFzVlPhbErTAqyYg/medium.jpg',
    artist: artists.first,
    votes: 64
  },
  {
    date: 'ca. 1665â€“1667',
    dimensions_text: '17 1/2 Ã— 15 3/4 in',
    height: 17.5,
    width: 15.75,
    slug: 'johannes-vermeer-study-of-a-young-woman',
    title: 'Study of a Young Woman',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/pLcp7hFbgtfYnmq-b_LXvg/medium.jpg',
    artist: artists[1],
    votes: 21
  },
  {
    date: '1665â€“1667',
    dimensions_text: '44 3/8 Ã— 34 1/2 in',
    height: 44.375,
    width: 34.5,
    slug: 'rembrandt-van-rijn-portrait-of-gerard-de-lairesse',
    title: 'Portrait of Gerard de Lairesse',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/6b4QduWxeA1kSnrifgm2Zw/medium.jpg',
    artist: artists[2],
    votes: 30
  },
  {
    date: '1600â€“1626',
    dimensions_text: '10 7/16 Ã— 6 15/16 in',
    height: 10.4375,
    width: 6.9375,
    slug: 'peter-paul-rubens-bust-of-pseudo-seneca',
    title: 'Bust of Pseudo-Seneca',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/RcoWk2PHQq6yqX7dpSyt-g/medium.jpg',
    artist: artists[3],
    votes: 96
  },
  {
    date: '1449',
    dimensions_text: '39 3/8 Ã— 33 3/4 in',
    height: 39.375,
    width: 33.75,
    slug: 'petrus-christus-a-goldsmith-in-his-shop',
    title: 'A Goldsmith in his Shop',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/0-QXL43Ox2QgwqkYoCjAjg/medium.jpg',
    artist: artists.first,
    votes: 80
  },
  {
    date: 'ca. 1635',
    dimensions_text: '80 1/4 Ã— 62 1/4 in',
    height: 80.25,
    width: 62.25,
    slug:
      'peter-paul-rubens-rubens-his-wife-helena-fourment-1614-1673-and-their-son-frans-1633-1678',
    title:
      'Rubens, His Wife Helena Fourment (1614â€“1673), and Their Son Frans (1633â€“1678)',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/miBYVNx3iV4AtBWgierQrg/medium.jpg',
    artist: artists[3],
    votes: 47
  },
  {
    date: '1653',
    dimensions_text: '56 1/2 Ã— 53 3/4 in',
    height: 56.5,
    width: 53.75,
    slug: 'rembrandt-van-rijn-aristotle-with-a-bust-of-homer',
    title: 'Aristotle with a Bust of Homer',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/q5OTabe7_Bu8kfxzK_UUag/medium.jpg',
    artist: artists[2],
    votes: 46
  },
  {
    date: 'ca. 1662',
    dimensions_text: '18 Ã— 16 in',
    height: 18,
    width: 16,
    slug: 'johannes-vermeer-young-woman-with-a-water-pitcher',
    title: 'Young Woman with a Water Pitcher',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/pdRjIGw58ecojporcDG0_w/medium.jpg',
    artist: artists[1],
    votes: 95
  },
  {
    date: '1660',
    dimensions_text: '31 5/8 Ã— 26 1/2 in',
    height: 31.625,
    width: 26.5,
    slug: 'rembrandt-van-rijn-self-portrait-1661',
    title: 'Self-Portrait',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/7EthRD-B57oEJovV77WH0Q/medium.jpg',
    artist: artists[2],
    votes: 41
  },
  {
    date: '1617',
    dimensions_text: '17 9/16 Ã— 9 3/4 in',
    height: 17.5625,
    width: 9.75,
    slug: 'peter-paul-rubens-portrait-of-nicolas-trigault-in-chinese-costume',
    title: 'Portrait of Nicolas Trigault in Chinese Costume',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/-VmrYlEp4nXEjtSa8-C7PA/medium.jpg',
    artist: artists[3],
    votes: 37
  },
  {
    date: 'ca. 1580â€“1585',
    dimensions_text: '16 1/4 Ã— 12 5/8 in',
    height: 16.25,
    width: 12.625,
    slug: 'bartholomaeus-spranger-diana-and-actaeon',
    title: 'Diana and Actaeon',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/FaqwCA1k4QjgaiGN8PElUQ/medium.jpg',
    artist: artists[4],
    votes: 30
  },
  {
    date: '1645',
    dimensions_text: '30 5/16 Ã— 25 3/16 in',
    height: 30.3125,
    width: 25.1875,
    slug: 'frans-hals-willem-coymans',
    title: 'Willem Coymans',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/gXMChrE5re4HdlIP6__LXQ/medium.jpg',
    artist: artists[5],
    votes: 25
  }
];
  
paintings = painting_data.map{|attributes| Painting.create(attributes)}

Pry.start