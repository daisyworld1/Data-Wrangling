
# ****
# ## JSON exercise
# 
# Using data in file 'data/world_bank_projects.json' and the techniques demonstrated above,
# 1. Find the 10 countries with most projects
# 2. Find the top 10 major project themes (using column 'mjtheme_namecode')
# 3. In 2. above you will notice that some entries have only the code and the name is missing. Create a dataframe with the missing names filled in.

# In[4]:


a=json.load((open('data/world_bank_projects.json')))


# In[5]:


b=json_normalize(a)


# In[7]:


df=pd.DataFrame(b)


# In[8]:


df.columns


# In[11]:


#1.Find the 10 countries with most projects
df_proj=df[['_id.$oid', 'countryname']]


# In[19]:


df_proj_by_country=df_project.groupby('countryname').count().sort_values(by='_id.$oid', ascending=False)


# In[21]:


print(df_proj_by_country.head(10))


# In[26]:


#2.Find the top 10 major project themes (using column 'mjtheme_namecode')
df_proj_themes=df[['_id.$oid', 'mjtheme_namecode']]


# In[148]:


pd.options.display.max_rows
pd.set_option('display.max_colwidth', -1)

print(df_proj_themes.iloc[0:5,1])


# In[51]:


count_theme={}
for row in df_proj_themes['mjtheme_namecode']:
    for theme in row:
            if theme['name'] in count_theme.keys():
                count_theme[theme['name']] += 1
            else:
                count_theme[theme['name']] = 1
print(count_theme)


# In[71]:


df_theme = pd.DataFrame([count_theme]).T.sort_values(by=0, ascending=False)


# In[77]:


print(df_theme.head(10))


# In[98]:


#3.In 2. above you will notice that some entries have only the code and the name is missing. 
#Create a dataframe with the missing names filled in.

theme_code=[]
theme_name=[]

for row in df_proj_themes['mjtheme_namecode']:
    for theme in row:
            theme_code.append(theme['code'])
            theme_name.append(theme['name'])
            
df_theme_table = pd.DataFrame({'code':theme_code,'name':theme_name})         


# In[115]:


#create a unique list of code_name mapping table
df_theme_table = df_theme_table.sort_values(by=['code','name'], ascending=False)
df_theme_table = df_theme_table.replace({'': None})
df_theme_table = df_theme_table.fillna(method='ffill')
df_theme_table = df_theme_table.drop_duplicates().set_index('code')
print(df_theme_table)


# In[127]:


#create a dictionary based on the theme table
theme_dict = df_theme_table.to_dict()['name']
for i in theme_dict.keys():
    print(i,theme_dict[i])


# In[153]:


#fill in missing values

for row in df['mjtheme_namecode']:
    for theme in row:
            if theme['name'] == '':
                theme['name'] = theme_dict[theme['code']]


# In[157]:


#check missing values
check={}
for row in df['mjtheme_namecode']:
    for theme in row:
            if theme['name'] in check.keys():
                check[theme['name']] += 1
            else:
                check[theme['name']] = 1
print(check)

