import * as zod from 'zod';

export const UserSchema = zod.object({
    username: zod.string().email(),      
    password: zod.string(),               
    name: zod.string().optional(),        
    isAdmin: zod.boolean().optional()     
});

export const UserLoginSchema = zod.object({
    username: zod.string().email(),      
    password: zod.string(),    
});

export const ProfileSchema = zod.object({
    first_name: zod.string(),
    middle_name: zod.string(),
    last_name: zod.string(),
    gender: zod.enum(['Male', 'Female','Other']), 
    dob: zod.date(),
    age: zod.number(),
    contact_number: zod.bigint(),
    address_1: zod.string(),
    address_2: zod.string().optional(),
    city: zod.string(),
    height: zod.number().int(),
    weight: zod.number().int().optional(),
    color: zod.string(),
    religion: zod.string(),
    cast_or_community: zod.string(),
    mother_tongue: zod.string(),
    marital_status: zod.enum(['Single', 'Married', 'Divorced', 'Widowed', 'Separated', 'Never Married', 'Awaiting Divorce']),
    dietary_preference: zod.enum(['Vegetarian', 'Non-Vegetarian']),
    occupation: zod.string(),
    income: zod.bigint(),
    father_name: zod.string(),
    mother_name: zod.string(),
    mother_occupation: zod.string(),
    father_occupation: zod.string(),
    mother_native: zod.string(),
    father_native: zod.string(),
    family_contact_no: zod.number().min(10).int(),
    number_of_siblings: zod.number().int().default(0),
    brother: zod.number().int().default(0),
    sister: zod.number().int().default(0),
    father: zod.boolean().optional().default(false),
    mother: zod.boolean().optional().default(false),
    zododiac_sign: zod.string(),
    birth_time: zod.string(),
    birth_place: zod.string(),
    // image: zod.string().array(),
    // horoscope_img: zod.string().array()
})