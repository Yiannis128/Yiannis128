use strict;

# Split the param_keys by space.
my @keys_array = split(",", $ENV{param_keys_string});
my @values_array = split(",", $ENV{param_values_string});

my $keys_array_length = @keys_array;
# Sub each key and value.
for (my $index = 0; $index < $keys_array_length; $index = $index + 1) {
    my $tag_name = @keys_array[$index];
    my $tag_value = @values_array[$index];
    s/{$tag_name}/$tag_value/g;
}

# Built in tag subs
s/{time}/$ENV{time}/g;
s/{article}/$ENV{html_article}/g;
