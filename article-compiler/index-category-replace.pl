# index-category-replace.pl

s/{category_name}/$ENV{category_name}/g;
s/{category_articles}/$ENV{category_articles}/g;

# Only replace category_pic if variable is not empty.
if ("$ENV{category_pic}" ne "") {
    s/{category_pic}/$ENV{category_pic}/g;
}