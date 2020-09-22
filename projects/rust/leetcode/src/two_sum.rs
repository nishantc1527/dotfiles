use std::collections::HashMap;

/// Does what you think it does
pub fn two_sum(nums: Vec<i32>, target: i32) -> Vec<i32> {
    let mut map: HashMap<i32, i32> = HashMap::new();

    for i in 0..nums.len() {
        let curr = target - nums[i];

        match map.get(&curr) {
            Some(&val) => return vec![i as i32, val],
            None => map.insert(nums[i], i as i32),
        };
    }

    return vec![];
}
