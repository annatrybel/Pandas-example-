* Select the first 10 values from the description column in reviews, assigning the result to variable first_descriptions.
        first_descriptions = reviews.loc[:9,'description']
        or
        first_descriptions = reviews.description.iloc[:10]

* Create a DataFrame italian_wines containing reviews of wines made in Italy. Hint: reviews.country equals what?
        italian_wines =reviews.loc[reviews.country=='Italy']

* Create a DataFrame top_oceania_wines containing all reviews with at least 95 points (out of 100) for wines from Australia or New Zealand.
        top_oceania_wines = reviews.loc[(reviews["country"].isin(['Australia', 'New Zealand'])) & (reviews["points"] >= 95)]

* I'm an economical wine buyer. Which wine is the "best bargain"? Create a variable bargain_wine with the title of the wine with the highest points-to-price ratio in the dataset.
        mask1 = (reviews['points'] / reviews ['price']).idxmax()
        bargain_wine = reviews['title'].loc[mask1]
        bargain_wine

* There are only so many words you can use when describing a bottle of wine. Is a wine more likely to be "tropical" or "fruity"?
  Create a Series descriptor_counts counting how many times each of these two words appears in the description column in the dataset. 
  (For simplicity, let's ignore the capitalized versions of these words.)
        mask1 = reviews.description.map(lambda lo: 'tropical' in lo)
        tropical = mask1.sum()

        mask2 = reviews.description.map(lambda lo: 'fruity' in lo)
        fruity = mask2.sum()

        descriptor_counts = pd.Series(    [tropical, fruity]     ,  index=['tropical','fruity']     )
        descriptor_counts

* We'd like to host these wine reviews on our website, but a rating system ranging from 80 to 100 points is too hard to understand - we'd like to translate them into simple star ratings.
  A score of 95 or higher counts as 3 stars, a score of at least 85 but less than 95 is 2 stars. Any other score is 1 star.
  Also, the Canadian Vintners Association bought a lot of ads on the site, so any wines from Canada should automatically get 3 stars, regardless of points.
  Create a series star_ratings with the number of stars corresponding to each review in the dataset.
        def stars(lines): 
            if 'Canada' == lines.country:
        stars= 3
            elif lines.points >= 95:
        stars= 3
            elif lines.points >= 85:
        stars= 2
            else:
        stars= 1
            return stars

        star_ratings = reviews.apply(stars, axis='columns')
        star_ratings

* Who are the most common wine reviewers in the dataset? Create a Series whose index is the taster_twitter_handle category from the dataset, and whose values count how many reviews each person wrote.
        reviews_written = reviews.groupby('taster_twitter_handle').taster_twitter_handle.count()

* What are the most expensive wine varieties? Create a variable sorted_varieties containing a copy of the dataframe from the previous question where varieties are sorted in descending order based on minimum price, then on maximum price (to break ties).
        sorted_varieties = price_extremes.sort_values(by=['min', 'max'], ascending = False)

*  What combination of countries and varieties are most common? Create a Series whose index is a MultiIndexof {country, variety} pairs. For example, a pinot noir produced in the US should map to {"US", "Pinot Noir"}. Sort the values in the Series in descending order based on wine count.
        country_variety_counts =  reviews.groupby(['country', 'variety']).variety.count().sort_values(ascending = False)

* What are the most common wine-producing regions? Create a Series counting the number of times each value occurs in the region_1 field. This field is often missing data, so replace missing values with Unknown. Sort in descending order. 
        reviews_per_region = reviews.region_1.fillna('Unknown').value_counts().sort_values(ascending=False)

* region_1 and region_2 are pretty uninformative names for locale columns in the dataset. Create a copy of reviews with these columns renamed to region and locale, respectively.
        renamed = reviews.rename(columns={'region_1':'region','region_2':'locale'})

* Set the index name in the dataset to wines.
        reindexed = reviews.rename_axis("wines", axis='rows')

* Identify loyal users (those who made the most purchases in the store)
        Users_purchases = user_df.groupby(‘user_id’, as_index=False) \
	        .agg({‘brand_name’: ‘count’}) \
	        .rename(columns={‘brand_name’:’purchases’}) \
	        .query(‘purchases’ >=5’)
        Determine the favorite brand of each loyal user:
        Lovely_brand_purchases_df=user_df.groupby([‘user_id’,’brand_name’], as_index=False) \
	        .agg({‘brand_info’:’count’}) \
	        .sort_values([‘user_id’,’brand_info’], ascending=[False,False]) \
	        .groupby(‘user_id’) \
	        .head(1) \
	        .rename(columns={‘brand_name’:’lovely_brand’, ‘brand_info’:’lovely_brand_purchases’})

* How to read only the required part of the data?
        Scaning = False
        For i in meal_data:
	        if  i.startwith(‘--------------------------‘):
		        scaning = False
		        continue
	        if scaning:
		        if ‘Meal#’ in i:
			        col_name = i
			        continue
		        all_data.append([value.strip() for value in i.split(‘;’)])
	        if  ’Non-delete saved meals’ in i:
		        scaning = True
		        continue

        final_col_names = [col. strip() for col in col_name.split(‘;’)]
        meal_df = pd.DataFrame(all_data, columns = final_col_names)

* How to record several conditions?
        Ads.data[(ads_data.ad_cost_type ==’CPC’) & (ads_data.event ==’click’)

