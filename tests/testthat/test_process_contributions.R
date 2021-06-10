### Test process_contributions function

test_that("Process_contributions processes data correctly", {

    data <- tibble::tibble(
      type = "question",
      ref = "1:7",
      content = c("To ask the Secretary of State for Health", NA, "To ask the Secretary of State for Environment",
                  "To ask the Secretary of State for Education","To ask the Secretary of State for the Home",
                  "To ask the Secretary of State for Foreign", "To ask the Secretary of State for Housing"),
      member = c("Sturdy, Julian", "Bradley, Ben", "Abbott, Diane", "Mak, Alan",
                 "Daby, Janet; Speaker", "Brock, Deirdre", "Leigh, Edward")
      )


    data_test <- process_contributions(data)

    expect_equal(length(data_test), 6)
    expect_equal(data_test$words[2], 8)
    expect_equal(data_test$member_second[4], "Speaker")
})
