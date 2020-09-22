mod fizzbuzz;
mod two_sum;

fn main() {
    fizzbuzz::fizzbuzz(15);
    println!("{:#?}", two_sum::two_sum(vec![1, 2, 3], 5));
}
